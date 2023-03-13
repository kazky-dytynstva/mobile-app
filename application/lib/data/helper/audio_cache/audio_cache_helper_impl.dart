import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/value_objects/file_path.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/chapter/chapter_entity.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:watcher/watcher.dart';

import 'audio_cache_helper.dart';

@LazySingleton(as: AudioCacheHelper)
class AudioCacheHelperImpl implements AudioCacheHelper {
  final FilePath _cacheFolderPath;

  AudioCacheHelperImpl(
    @Named("cacheDirPath") FilePath cacheDirPath,
  ) : _cacheFolderPath = FilePath("${cacheDirPath.get()}/audio");

  @override
  Future<bool> delete(TaleId taleId, int index) async {
    final path = _createFilePath(id: taleId, index: index);
    final file = File(path);
    if (!await file.exists()) {
      return false;
    }
    await file.delete();
    return true;
  }

  @override
  Future<Unit> deleteAll() async {
    final directory = Directory(_cacheFolderPath.get());
    if (!directory.existsSync()) {
      return unit;
    }
    await directory.delete(recursive: true);
    return unit;
  }

  @override
  Future<bool> isCached(TaleId id, TaleChapterEntity entity) async {
    final path = _createFilePath(id: id, index: entity.index);
    final file = File(path);
    if (!file.existsSync()) {
      return false;
    }
    final fileSize = await file.length();
    final isCached = fileSize == (entity.audioSize ?? 0);
    return isCached;
  }

  @override
  FilePath getTaleAudioPath(TaleId id, int index) {
    final path = _createFilePath(id: id, index: index);
    return FilePath(path);
  }

  @override
  Future<IntPositive> getCachedFilesAmount() async {
    final directory = Directory(_cacheFolderPath.get());
    if (!directory.existsSync()) {
      return IntPositive(0);
    }
    final count = directory.listSync().length;
    return IntPositive(count);
  }

  @override
  Future<IntPositive> getCachedFilesSize() async {
    final directory = Directory(_cacheFolderPath.get());
    if (!directory.existsSync()) {
      return IntPositive(0);
    }
    int size = 0;
    directory.listSync(recursive: true).forEach((element) {
      size += element.statSync().size;
    });
    return IntPositive(size);
  }

  @override
  Stream<Unit> watchWhenFilesChanged() {
    final transformer = StreamTransformer.fromHandlers(
      handleData: (WatchEvent _, EventSink<Unit> sink) => sink.add(unit),
    );
    return DirectoryWatcher(_cacheFolderPath.get())
        .events
        .debounce(const Duration(milliseconds: 100))
        .transform(transformer);
  }

  String _createFilePath({
    required TaleId id,
    required int index,
  }) =>
      "${_cacheFolderPath.get()}/${id.get()}/$index.mp3";
}
