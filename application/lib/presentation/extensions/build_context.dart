import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
