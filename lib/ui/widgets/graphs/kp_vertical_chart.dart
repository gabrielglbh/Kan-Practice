import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as c;
import 'package:kanpractice/ui/consts.dart';

class VerticalBarData {
  final String x;
  final double y;
  final Color color;
  const VerticalBarData(
      {required this.x, required this.y, required this.color});
}

class KPVerticalBarChart extends StatelessWidget {
  /// List of [VerticalBarData] to paint over a [c.BarChart]. See [VerticalBarData].
  final List<VerticalBarData> dataSource;
  final void Function(c.SelectionModel<String>)? onBarTapped;
  const KPVerticalBarChart({
    Key? key,
    required this.dataSource,
    this.onBarTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomSizes.defaultSizeWinRateBarChart * 1.5,
      width: MediaQuery.of(context).size.width - Margins.margin48,
      child: c.BarChart(
        [
          c.Series<VerticalBarData, String>(
            id: "Data",
            domainFn: (VerticalBarData data, _) => data.x,
            colorFn: (VerticalBarData data, _) =>
                c.ColorUtil.fromDartColor(data.color),
            measureFn: (VerticalBarData data, _) => data.y,
            data: dataSource,
          )
        ],
        primaryMeasureAxis: c.NumericAxisSpec(
            tickProviderSpec: const c.BasicNumericTickProviderSpec(
                dataIsInWholeNumbers: true, desiredTickCount: 5),
            renderSpec: c.GridlineRendererSpec(
              labelStyle: c.TextStyleSpec(
                  color: c.ColorUtil.fromDartColor(
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white)),
              lineStyle: c.LineStyleSpec(
                  color: c.ColorUtil.fromDartColor(
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white)),
            )),
        domainAxis: c.OrdinalAxisSpec(
            renderSpec: c.SmallTickRendererSpec(
          labelRotation: 45,
          labelStyle: c.TextStyleSpec(
              color: c.ColorUtil.fromDartColor(
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white)),
          lineStyle: c.LineStyleSpec(
              color: c.ColorUtil.fromDartColor(
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white)),
        )),
        animate: true,
        vertical: true,
        selectionModels: onBarTapped != null
            ? [
                c.SelectionModelConfig(
                    type: c.SelectionModelType.info,
                    changedListener: onBarTapped),
              ]
            : null,
      ),
    );
  }
}
