enum PlayAudioStatus {
  idle,
  loading,
  playing,
  paused,
  completed,
}

extension PlayAudioStatusX on PlayAudioStatus {
  bool get isIdle => this == PlayAudioStatus.idle;

  bool get isLoading => this == PlayAudioStatus.loading;

  bool get isPlaying => this == PlayAudioStatus.playing;

  bool get isPaused => this == PlayAudioStatus.paused;

  bool get isCompleted => this == PlayAudioStatus.completed;
}
