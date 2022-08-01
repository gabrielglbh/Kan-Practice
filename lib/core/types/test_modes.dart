import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum Tests { lists, blitz, time, numbers, less, categories, folder }

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
      case Tests.categories:
        return "test_mode_categories".tr();
      case Tests.folder:
        return "test_mode_folder".tr();
    }
  }

  String get nameAbbr {
    switch (this) {
      case Tests.lists:
        return "abbr_test_mode_selection".tr();
      case Tests.blitz:
        return "abbr_test_mode_blitz".tr();
      case Tests.time:
        return "abbr_test_mode_remembrance".tr();
      case Tests.numbers:
        return "abbr_test_mode_number".tr();
      case Tests.less:
        return "abbr_test_mode_less".tr();
      case Tests.categories:
        return "abbr_test_mode_categories".tr();
      case Tests.folder:
        return "abbr_test_mode_folder".tr();
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
      case Tests.categories:
        return Icons.category;
      case Tests.folder:
        return Icons.folder_rounded;
    }
  }
}

class TestsUtils {
  /// Maps the int received from the source to a Tests. Based on [map]
  static Tests mapTestMode(int map) {
    switch (map) {
      case 1:
        return Tests.blitz;
      case 2:
        return Tests.time;
      case 3:
        return Tests.numbers;
      case 4:
        return Tests.less;
      case 5:
        return Tests.categories;
      case 6:
        return Tests.folder;
      case 0:
      default:
        return Tests.lists;
    }
  }
}
