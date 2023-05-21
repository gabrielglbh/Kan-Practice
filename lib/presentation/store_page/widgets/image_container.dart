import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class ImageContainer extends StatefulWidget {
  final double? height;
  final String image;
  const ImageContainer({super.key, this.height, required this.image});

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  void didChangeDependencies() {
    precacheImage(Image.asset('assets/images/${widget.image}').image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.height ?? MediaQuery.of(context).size.width / 1.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(KPRadius.radius16),
        child: Image.asset('assets/images/${widget.image}'),
      ),
    );
  }
}
