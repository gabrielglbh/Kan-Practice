import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class KPListPercentageIndicator extends StatelessWidget {
  /// Value to show on the center of a [LinearPercentIndicator] as a percentage
  /// over 100.
  final double value;
  const KPListPercentageIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      percent: value,
      backgroundColor: KPColors.secondaryColor,
      progressColor: KPColors.secondaryDarkerColor,
      lineHeight: 30,
      barRadius: const Radius.circular(KPRadius.radius8),
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
