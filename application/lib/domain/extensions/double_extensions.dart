extension DoubleX on double {
  double rounded({int numbAfterComma = 2}) {
    final asString = toStringAsFixed(numbAfterComma);
    return double.parse(asString);
  }
}
