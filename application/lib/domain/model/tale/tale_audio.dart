import 'package:equatable/equatable.dart';
import 'package:mobile_app/domain/value_objects/file_path.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';

// ignore: must_be_immutable
class TaleAudio extends Equatable {
  final IntPositive chapterIndex;
  final Duration duration;
  final UrlString url;
  final FilePath filePath;
  final List<ImageUrl> images;
  final Future<bool> isCachedFuture;
  bool _isCachedSync = false;

  TaleAudio(
    this.chapterIndex,
    this.duration,
    this.url,
    this.images,
    this.filePath,
    this.isCachedFuture,
  ) : assert(images.isNotEmpty) {
    isCachedFuture.then((value) => _isCachedSync = value);
  }

  bool get isCached => _isCachedSync;

  @override
  List<Object> get props => [
        chapterIndex,
        duration,
        url,
        filePath,
        images,
        _isCachedSync,
      ];
}
