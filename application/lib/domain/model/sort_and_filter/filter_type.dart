enum TaleFilterType {
  all,
  unwatched,
  favorite,
  national,
  author,
  audio,
  lullaby,
  poem,
  lastAdded,
  hidden,
}

extension TaleFilterTypeX on TaleFilterType {
  bool get isFav => TaleFilterType.favorite == this;

  bool get isAudio => TaleFilterType.audio == this;

  bool get isHidden => TaleFilterType.hidden == this;
}
