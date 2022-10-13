import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WinRateChart extends StatelessWidget {
  /// Win rate value to paint in the [SfRadialGauge] as a percentage over 100
  final double winRate;

  /// Title of the [SfRadialGauge]
  final String? title;

  /// Size of the [SfRadialGauge]
  final double size;

  /// [Color] of the [SfRadialGauge]
  final Color backgroundColor;

  /// [Color] of the actual win rate
  final Color chartColor;

  /// Value of the [winRate] text size
  final double? rateSize;

  /// Whether to show or not the gauge title
  final bool showGaugeAnnotation;

  /// Padding to the graph
  final EdgeInsets padding;

  /// Size of the line graph
  final double widthLine;

  /// Offset from the actual graph to the line
  final double pointerOffset;
  const WinRateChart(
      {Key? key,
      this.title,
      required this.winRate,
      this.size = CustomSizes.defaultSizeWinRateChart,
      this.rateSize,
      this.backgroundColor = CustomColors.secondaryColor,
      this.chartColor = Colors.white,
      this.showGaugeAnnotation = true,
      this.padding = const EdgeInsets.all(Margins.margin8),
      this.widthLine = 0.1,
      this.pointerOffset = 0.1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      margin: padding,
      child: SfRadialGauge(
        title: title != null ? GaugeTitle(text: title!) : null,
        enableLoadingAnimation: true,
        animationDuration: 1000,
        axes: <RadialAxis>[
          RadialAxis(
              minimum: 0,
              maximum: 1,
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              axisLineStyle: AxisLineStyle(
                thickness: 1,
                color: backgroundColor,
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              annotations: showGaugeAnnotation
                  ? <GaugeAnnotation>[
                      GaugeAnnotation(
                          positionFactor: 0.5,
                          angle: 90,
                          widget: Text(
                              GeneralUtils.getFixedPercentageAsString(
                                  winRate == DatabaseConstants.emptyWinRate
                                      ? 0
                                      : winRate),
                              style: TextStyle(
                                  color: Colors.white, fontSize: rateSize)))
                    ]
                  : null,
              pointers: <GaugePointer>[
                RangePointer(
                  value:
                      winRate == DatabaseConstants.emptyWinRate ? 0 : winRate,
                  width: widthLine,
                  color: chartColor,
                  pointerOffset: pointerOffset,
                  cornerStyle: CornerStyle.bothCurve,
                  sizeUnit: GaugeSizeUnit.factor,
                )
              ])
        ],
      ),
    );
  }
}
