import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WinRateChart extends StatelessWidget {
  /// Win rate value to paint in the [SfRadialGauge] as a percentage over 100
  final double winRate;
  /// Title of the [SfRadialGauge]
  final String title;
  /// Size of the [SfRadialGauge]
  final double size;
  /// [Color] of the [SfRadialGauge]
  final Color chartColor;
  /// Value of the [winRate] text size
  final double? rateSize;
  const WinRateChart({required this.title, required this.winRate, this.size = 80, this.rateSize,
    this.chartColor = CustomColors.secondaryColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size, width: size,
      margin: EdgeInsets.all(8),
      child: SfRadialGauge(
        title: GaugeTitle(text: title),
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
              color: chartColor,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                positionFactor: 0.5,
                angle: 90,
                widget: Text((((winRate == -1 ? 0 : winRate))*100).toStringAsFixed(2),
                  style: TextStyle(color: Colors.white, fontSize: rateSize)
                )
              )
            ],
            pointers: <GaugePointer>[
              RangePointer(
                value: winRate == -1 ? 0 : winRate,
                width: 0.1,
                color: Colors.white,
                pointerOffset: 0.1,
                cornerStyle: CornerStyle.bothCurve,
                sizeUnit: GaugeSizeUnit.factor,
              )
            ]
          )
        ],
      ),
    );
  }
}
