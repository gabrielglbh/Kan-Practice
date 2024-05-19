import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPLearningTextBox extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final double top, bottom;
  final double? right, left;
  final TextAlign textAlign;
  const KPLearningTextBox({
    super.key,
    required this.text,
    required this.textStyle,
    this.top = 0,
    this.bottom = 0,
    this.right,
    this.left,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: left ?? KPMargins.margin32,
        right: right ?? KPMargins.margin32,
      ),
      child: Text(text, style: textStyle, textAlign: textAlign),
    );
  }
}
