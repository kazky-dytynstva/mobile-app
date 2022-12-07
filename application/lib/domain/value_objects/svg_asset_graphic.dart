class SvgAssetGraphic {
  final String path;
  final String name;

  const SvgAssetGraphic({
    required this.name,
  })  : assert(name.length > 0),
        path = 'assets/graphics/$name.svg';
}
