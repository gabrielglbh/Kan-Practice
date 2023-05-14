import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class ImageContainer extends StatelessWidget {
  final double? height;
  final String image;
  const ImageContainer({super.key, this.height, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: height ?? MediaQuery.of(context).size.width / 1.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(KPRadius.radius16),
        child: Image.asset('assets/images/$image'),
      ),
    );
  }
}
