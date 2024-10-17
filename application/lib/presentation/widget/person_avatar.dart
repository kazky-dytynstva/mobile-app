import 'package:flutter/material.dart' hide NetworkImage;
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/network_image.dart';

class PersonAvatar extends StatelessWidget {
  final ImageUrl photoUrl;
  final double width;
  final double height;
  final bool withRoundedCorners;

  const PersonAvatar({
    required this.photoUrl,
    required this.width,
    required this.height,
    this.withRoundedCorners = true,
    super.key,
  });

  PersonAvatar.squared({
    required this.photoUrl,
    this.withRoundedCorners = true,
    double? size,
    super.key,
  })  : width = size ?? R.dimen.personAvatarList,
        height = size ?? R.dimen.personAvatarList;

  @override
  Widget build(BuildContext context) {
    final image = NetworkImage(
      photoUrl,
      width: width,
      height: height,
    );
    if (!withRoundedCorners) return image;
    return ClipRRect(
      borderRadius: R.styles.imageBorderRadiusSmall,
      child: image,
    );
  }
}
