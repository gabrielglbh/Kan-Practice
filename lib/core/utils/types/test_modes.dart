import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum Tests {
  lists, blitz, time, numbers, less
}

extension TestsExt on Tests {
  String get name {
    switch (this) {
      case Tests.lists:
        return "test_mode_selection".tr();
      case Tests.blitz:
        return "test_mode_blitz".tr();
      case Tests.time:
        return "test_mode_remembrance".tr();
      case Tests.numbers:
        return "test_mode_number".tr();
      case Tests.less:
        return "test_mode_less".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case Tests.lists:
        return Icons.select_all_rounded;
      case Tests.blitz:
        return Icons.flash_on_rounded;
      case Tests.time:
        return Icons.access_time_rounded;
      case Tests.numbers:
        return Icons.pin_rounded;
      case Tests.less:
        return Icons.indeterminate_check_box_outlined;
    }
  }
}

class TestsUtils {
  /// Maps the String received from the source to a Tests. Based on [map]
  static Tests mapTestMode(String map) {
    if (map == 'blitz_bottom_sheet_label'.tr()) return Tests.blitz;
    else if (map == 'remembrance_bottom_sheet_label'.tr()) return Tests.time;
    else if (map == 'number_bottom_sheet_label'.tr()) return Tests.numbers;
    else if (map == 'less_pct_bottom_sheet_label'.tr()) return Tests.less;
    /// If the map consists of various lessons, just return lists.
    else return Tests.lists;
  }
}