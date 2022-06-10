import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum LearningMode { random, spatial }

extension LearningModeExt on LearningMode {
  String get name {
    switch (this) {
      case LearningMode.random:
        return "list_details_learningMode_random".tr();
      case LearningMode.spatial:
        return "list_details_learningMode_spatial".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case LearningMode.random:
        return Icons.shuffle;
      case LearningMode.spatial:
        return Icons.spa_rounded;
    }
  }
}
