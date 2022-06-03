import 'package:flutter/material.dart';

enum VisualizationMode { barChart, radialChart }

extension VisualizationModeExt on VisualizationMode {
  String get name {
    switch (this) {
      case VisualizationMode.barChart:
        return "barChart";
      case VisualizationMode.radialChart:
        return "radialChart";
    }
  }

  Widget get icon {
    switch (this) {
      case VisualizationMode.radialChart:
        return const RotatedBox(
          quarterTurns: 1,
          child: Icon(Icons.bar_chart_rounded),
        );
      case VisualizationMode.barChart:
        return const Icon(Icons.donut_large_rounded);
    }
  }

  static VisualizationMode mode(String name) {
    switch (name) {
      case "barChart":
        return VisualizationMode.barChart;
      case "radialChart":
      default:
        return VisualizationMode.radialChart;
    }
  }

  static VisualizationMode toggle(VisualizationMode mode) {
    switch (mode) {
      case VisualizationMode.barChart:
        return VisualizationMode.radialChart;
      case VisualizationMode.radialChart:
        return VisualizationMode.barChart;
    }
  }
}
