class SvgAssetIcon {
  final String path;
  final String name;

  const SvgAssetIcon({
    required this.name,
  })  : assert(name.length >= 4),
        path = 'assets/icons/$name.svg';
}
