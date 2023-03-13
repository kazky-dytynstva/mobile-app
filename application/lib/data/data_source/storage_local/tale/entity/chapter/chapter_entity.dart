import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

const String _keyIndex = 'index';
const String _keyTitle = 'title';
const String _keyImages = 'images';
const String _keyText = 'text';
const String _keyAudioDuration = 'audio_duration';
const String _keyAudioSize = 'audio_size';

@immutable
class TaleChapterEntity extends Equatable {
  final int _index;
  final String? _title;
  final int? _imageCount;
  final List<String>? _text;
  final int? _audioDuration;
  final int? _audioSize;

  int get index => _index;

  String? get title => _title;

  int? get imageCount => _imageCount;

  List<String>? get text => _text;

  int? get audioDuration => _audioDuration;

  int? get audioSize => _audioSize;

  TaleChapterEntity(Map<String, dynamic> map)
      : _index = map[_keyIndex] as int,
        _title = map[_keyTitle] as String?,
        _imageCount = map[_keyImages] as int?,
        _text = map[_keyText] as List<String>?,
        _audioDuration = map[_keyAudioDuration] as int?,
        _audioSize = map[_keyAudioSize] as int?;

  const TaleChapterEntity.create({
    required int index,
    required String? title,
    required int? imageCount,
    required List<String>? text,
    required int? audioDuration,
    required int? audioSize,
  })  : assert((text?.length ?? 0) > 0 == true || (audioSize ?? 0) > 0 == true),
        _index = index,
        _title = title,
        _imageCount = imageCount,
        _text = text,
        _audioDuration = audioDuration,
        _audioSize = audioSize;

  Map<String, dynamic> toMap() => {
        _keyIndex: index,
        _keyTitle: title,
        _keyText: text,
        _keyImages: imageCount,
        _keyAudioDuration: audioDuration,
        _keyAudioSize: audioSize,
      };

  @override
  List<Object?> get props => [
        _index,
        _title,
        _imageCount,
        _text,
        _audioDuration,
        _audioSize,
      ];
}
