enum SettingsPageType {
  general,
  text,
  audio,
}

extension SettingsPageTypeX on SettingsPageType {
  T map<T>({
    required T Function() general,
    required T Function() text,
    required T Function() audio,
  }) {
    switch (this) {
      case SettingsPageType.general:
        return general();
      case SettingsPageType.text:
        return text();
      case SettingsPageType.audio:
        return audio();
    }
  }
}
