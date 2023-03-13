import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

const String _keyAuthors = 'authors';
const String _keyReaders = 'readers';
const String _keyMusicians = 'musicians';
const String _keyTranslators = 'translators';
const String _keyGraphics = 'graphics';

@immutable
class TaleCrewEntity extends Equatable {
  final List<int>? _authors;
  final List<int>? _readers;
  final List<int>? _musicians;
  final List<int>? _translators;
  final List<int>? _graphics;

  List<int>? get authors => _authors;

  List<int>? get readers => _readers;

  List<int>? get musicians => _musicians;

  List<int>? get translators => _translators;

  List<int>? get graphics => _graphics;

  TaleCrewEntity(Map<String, dynamic> map)
      : _authors = map[_keyAuthors] as List<int>?,
        _readers = map[_keyReaders] as List<int>?,
        _musicians = map[_keyMusicians] as List<int>?,
        _translators = map[_keyTranslators] as List<int>?,
        _graphics = map[_keyGraphics] as List<int>?;

  const TaleCrewEntity.create({
    required List<int>? authors,
    required List<int>? readers,
    required List<int>? musicians,
    required List<int>? translators,
    required List<int>? graphics,
  })  : _authors = authors,
        _readers = readers,
        _musicians = musicians,
        _translators = translators,
        _graphics = graphics;

  Map<String, dynamic> toMap() => {
        _keyAuthors: authors,
        _keyReaders: readers,
        _keyTranslators: translators,
        _keyMusicians: musicians,
        _keyGraphics: graphics,
      };

  @override
  List<Object?> get props => [
        _authors,
        _readers,
        _musicians,
        _translators,
        _graphics,
      ];
}
