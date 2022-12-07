import 'package:flutter/material.dart';

extension ColorX on Color {
  bool get isDark => computeLuminance() < 0.5;

  String toHexTriplet() =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
