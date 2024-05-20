import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class KPLinearGraph extends StatelessWidget {
  final double value;
  final Color color;
  const KPLinearGraph({
    super.key,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Utils.getFixedPercentageAsString(
              value == DatabaseConstants.emptyWinRate ? 0 : value),
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        const SizedBox(height: KPMargins.margin4),
        SfLinearGauge(
          maximum: 1,
          showTicks: false,
          minorTicksPerInterval: 0,
          showLabels: false,
          barPointers: <LinearBarPointer>[
            LinearBarPointer(
              value: 1,
              enableAnimation: false,
              edgeStyle: LinearEdgeStyle.bothCurve,
              color: Theme.of(context).colorScheme.primaryFixedDim,
            ),
            LinearBarPointer(
              value: value == DatabaseConstants.emptyWinRate ? 0 : value,
              edgeStyle: LinearEdgeStyle.bothCurve,
              color: color,
            ),
          ],
        ),
      ],
    );
  }
}
