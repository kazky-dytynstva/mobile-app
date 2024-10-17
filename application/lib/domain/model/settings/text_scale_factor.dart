import 'package:flutter/material.dart';

enum TextScaleFactor {
  s(TextScaler.linear(0.7)),
  m(TextScaler.linear(1)),
  l(TextScaler.linear(1.5)),
  xl(TextScaler.linear(2.0));

  final TextScaler value;

  const TextScaleFactor(this.value);
}
