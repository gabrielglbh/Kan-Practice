import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum LearningMode { random, spatial, fifo }

extension LearningModeExt on LearningMode {
  String get name {
    switch (this) {
      case LearningMode.random:
        return "list_details_learningMode_random".tr();
      case LearningMode.spatial:
        return "list_details_learningMode_spatial".tr();
      case LearningMode.fifo:
        return "list_details_learningMode_fifo".tr();
    }
  }

  String get desc {
    switch (this) {
      case LearningMode.random:
        return "list_details_learningMode_random_desc".tr();
      case LearningMode.spatial:
        return "list_details_learningMode_spatial_desc".tr();
      case LearningMode.fifo:
        return "list_details_learningMode_fifo_desc".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case LearningMode.random:
        return Icons.shuffle;
      case LearningMode.spatial:
        return Icons.alt_route_rounded;
      case LearningMode.fifo:
        return Icons.area_chart_rounded;
    }
  }
}
