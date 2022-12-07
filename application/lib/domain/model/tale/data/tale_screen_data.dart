/// Represent an option to switch to a different [TalePageType]
enum TaleSwitchType {
  none,
  text,
  audio,
}

enum TalePageType {
  text,
  audio,
}

enum TaleBottomBarAction {
  back,
  more,
  fav,
  change,
  rating,
  crew,
  tableOfContent,
}

extension TalePageTypeX on TalePageType {
  bool get isText => this == TalePageType.text;

  bool get isAudio => this == TalePageType.audio;

  TalePageType toggle() {
    switch (this) {
      case TalePageType.text:
        return TalePageType.audio;
      case TalePageType.audio:
        return TalePageType.text;
    }
  }
}
