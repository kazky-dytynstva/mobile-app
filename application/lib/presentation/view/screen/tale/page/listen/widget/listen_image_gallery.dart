import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/tale_image.dart';

class ListenImageGallery extends StatefulWidget {
  final List<ImageUrl> images;
  final int currentIndex;

  const ListenImageGallery({
    Key? key,
    required this.images,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<ListenImageGallery> createState() => _ListenImageGalleryState();
}

class _ListenImageGalleryState extends State<ListenImageGallery> {
  late final controller = PageController();

  @override
  void didUpdateWidget(covariant ListenImageGallery oldWidget) {
    if (!isSingleImage) {
      controller.animateToPage(
        widget.currentIndex,
        duration: R.durations.animLong,
        curve: Curves.easeInOut,
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get isSingleImage => widget.images.length == 1;

  @override
  Widget build(BuildContext context) {
    final content = isSingleImage ? _buildImage(0) : _buildPagesWithIndicator();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.screenPaddingSide),
      child: AspectRatio(
        aspectRatio: 1,
        child: content,
      ),
    );
  }

  Widget _buildPagesWithIndicator() => _buildPages();

  Widget _buildPages() => PageView.builder(
        controller: controller,
        itemBuilder: (_, int index) => _buildImage(index),
        itemCount: widget.images.length,
        physics: const NeverScrollableScrollPhysics(),
      );

  Widget _buildImage(int index) => TaleImage(imageUrl: widget.images[index]);
}
