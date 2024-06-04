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
    double pct = value * 100;
    return LinearPercentIndicator(
      percent: value,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      progressColor: Theme.of(context).colorScheme.onPrimaryContainer,
      lineHeight: 30,
      barRadius: const Radius.circular(KPRadius.radius8),
      animation: true,
      animationDuration: 1000,
      animateFromLastPercent: true,
      center: Text(
        value == 1 ? "100%" : "${pct.toStringAsPrecision(2)}%",
        style: TextStyle(
            color: pct <= 51
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.primaryContainer,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
