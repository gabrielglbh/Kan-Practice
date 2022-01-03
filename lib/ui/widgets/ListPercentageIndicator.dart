import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ListPercentageIndicator extends StatelessWidget {
  /// Value to show on the center of a [LinearPercentIndicator] as a percentage
  /// over 100.
  final double value;
  const ListPercentageIndicator({required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      percent: value,
      backgroundColor: CustomColors.secondaryColor,
      progressColor: CustomColors.secondaryDarkerColor,
      lineHeight: 30,
      animation: true,
      animationDuration: 1000,
      animateFromLastPercent: true,
      center: Text(value == 1 ? "100%" : "${(value*100).toStringAsPrecision(2)}%",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
