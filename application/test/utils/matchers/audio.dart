import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';

Matcher equalAudioSource(ProgressiveAudioSource expected) =>
    _UriAudioSourceMatcher(expected);

class _UriAudioSourceMatcher extends Matcher {
  final UriAudioSource expected;

  _UriAudioSourceMatcher(this.expected);

  @override
  Description describe(Description description) => description;

  @override
  bool matches(item, Map<dynamic, dynamic> matchState) {
    if (item is! UriAudioSource) return false;

    return item.tag == expected.tag &&
        item.uri == expected.uri &&
        mapEquals(item.headers, expected.headers) &&
        item.duration == expected.duration;
  }
}
