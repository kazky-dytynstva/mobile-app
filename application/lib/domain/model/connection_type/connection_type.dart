enum ConnectionType {
  none,
  wifi,
  mobile,
}

extension ConnectionTypeX on ConnectionType {
  bool get isWifi => this == ConnectionType.wifi;

  bool get isMobile => this == ConnectionType.mobile;

  bool get isNone => this == ConnectionType.none;
}
