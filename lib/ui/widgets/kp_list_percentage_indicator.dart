import 'package:flutter/material.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class KPListPercentageIndicator extends StatelessWidget {
  /// Value to show on the center of a [LinearPercentIndicator] as a percentage
  /// over 100.
  final double value;
  const KPListPercentageIndicator({Key? key, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      percent: value,
      backgroundColor: CustomColors.secondaryColor,
      progressColor: CustomColors.secondaryDarkerColor,
      lineHeight: 30,
      barRadius: const Radius.circular(CustomRadius.radius8),
      animation: true,
      animationDuration: 1000,
      animateFromLastPercent: true,
      center: Text(
        value == 1 ? "100%" : "${(value * 100).toStringAsPrecision(2)}%",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
