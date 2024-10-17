import 'package:flutter/material.dart' hide NetworkImage;
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/network_image.dart';

class TaleImage extends StatelessWidget {
  final ImageUrl imageUrl;
  final double? width;
  final double? height;
  final BorderRadius? radius;

  const TaleImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final image = _createImage();
    return ClipRRect(
      borderRadius: radius ?? R.styles.imageBorderRadius,
      child: image,
    );
  }

  Widget _createImage() => NetworkImage(
        imageUrl,
        createPlaceholder: _createPlaceholder,
        width: width,
        height: height,
      );

  Widget _createPlaceholder(BuildContext context) => const Center();
}
