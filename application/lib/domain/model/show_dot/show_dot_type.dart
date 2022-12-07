enum ShowDotType {
  donation,
  whatsNew,
  unknown,
}

extension ShowDotTypeX on ShowDotType {
  bool get isUnknown => this == ShowDotType.unknown;
}
