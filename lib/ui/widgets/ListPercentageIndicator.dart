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
    return Padding(
      padding: EdgeInsets.only(bottom: Margins.margin16, right: Margins.margin16, left: Margins.margin16),
      child: LinearPercentIndicator(
        percent: value,
        backgroundColor: CustomColors.secondarySubtleColor,
        progressColor: CustomColors.secondaryColor,
        lineHeight: 30,
        animation: true,
        animationDuration: 1000,
        animateFromLastPercent: true,
        center: Text(value == 1 ? "100%" : "${(value*100).toStringAsPrecision(2)}%",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
