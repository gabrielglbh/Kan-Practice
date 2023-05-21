import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum TestFilters {
  all,
  lists,
  blitz,
  time,
  numbers,
  less,
  categories,
  folder,
  daily,
  translation,
}

extension TestFiltersExt on TestFilters {
  String get nameAbbr {
    switch (this) {
      case TestFilters.all:
        return "all_filter".tr();
      case TestFilters.lists:
        return "abbr_test_mode_selection".tr();
      case TestFilters.blitz:
        return "abbr_test_mode_blitz".tr();
      case TestFilters.time:
        return "abbr_test_mode_remembrance".tr();
      case TestFilters.numbers:
        return "abbr_test_mode_number".tr();
      case TestFilters.less:
        return "abbr_test_mode_less".tr();
      case TestFilters.categories:
        return "abbr_test_mode_categories".tr();
      case TestFilters.folder:
        return "abbr_test_mode_folder".tr();
      case TestFilters.daily:
        return "abbr_test_mode_daily".tr();
      case TestFilters.translation:
        return "abbr_test_mode_translation".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case TestFilters.all:
        return Icons.all_out_rounded;
      case TestFilters.lists:
        return Icons.select_all_rounded;
      case TestFilters.blitz:
        return Icons.flash_on_rounded;
      case TestFilters.time:
        return Icons.access_time_rounded;
      case TestFilters.numbers:
        return Icons.pin_rounded;
      case TestFilters.less:
        return Icons.indeterminate_check_box_outlined;
      case TestFilters.categories:
        return Icons.category;
      case TestFilters.folder:
        return Icons.folder_rounded;
      case TestFilters.daily:
        return Icons.calendar_today;
      case TestFilters.translation:
        return Icons.travel_explore_rounded;
    }
  }
}
