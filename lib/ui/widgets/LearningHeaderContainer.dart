import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class LearningHeaderContainer extends StatelessWidget {
  final double fontSize;
  final double height;
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double top, bottom, right, left;
  final double? horizontal;
  const LearningHeaderContainer({
    this.fontSize = FontSizes.fontSize24, required this.height, required this.text,
    this.top = 0, this.bottom = 0, this.right = 0, this.left = 0,
    this.color, this.fontWeight, this.horizontal
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: horizontal == null
            ? MediaQuery.of(context).size.width / 4 : horizontal!
      ),
      margin: EdgeInsets.only(top: top),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(text,
          style: TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight)
        )
      ),
    );
  }
}
