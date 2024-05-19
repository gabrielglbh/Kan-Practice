import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauge;

class RadialGraphLegend extends StatelessWidget {
  final double rate;
  final Color color;
  final String text;
  const RadialGraphLegend({
    super.key,
    required this.rate,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: SizedBox(
            width: KPMargins.margin8,
            height: KPMargins.margin12,
            child: gauge.SfRadialGauge(
              enableLoadingAnimation: false,
              axes: <gauge.RadialAxis>[
                gauge.RadialAxis(
                  minimum: 0,
                  maximum: 1,
                  showLabels: false,
                  showTicks: false,
                  startAngle: 270,
                  endAngle: 270,
                  pointers: <gauge.GaugePointer>[
                    gauge.RangePointer(
                      value: 0.8,
                      width: 0.5,
                      color: color,
                      cornerStyle: gauge.CornerStyle.bothCurve,
                      sizeUnit: gauge.GaugeSizeUnit.factor,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "$text:",
                  style: const TextStyle(fontSize: KPMargins.margin12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  rate != DatabaseConstants.emptyWinRate
                      ? Utils.getFixedPercentageAsString(rate)
                      : "0%",
                  style: TextStyle(
                      fontSize: KPMargins.margin12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black87
                          : Colors.white),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
