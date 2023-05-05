import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// TODO when updating:
/// When adding a new test, be aware of the need to update the DB
/// [TestDataTableFields] and [TestSpecificDataTableFields] along
/// the [TestQueries] and [BackUpQueries] queries.  Dont forget
/// the switch checks in the base code (see Usages on [Tests]).
/// Also, add them to [TestFilters]
/// Be aware of the stats page and bloc as the rates will change.
enum Tests {
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
      case Tests.daily:
        return "test_mode_daily".tr();
      case Tests.translation:
        return "test_mode_translation".tr();
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
      case Tests.daily:
        return "abbr_test_mode_daily".tr();
      case Tests.translation:
        return "abbr_test_mode_translation".tr();
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
      case Tests.daily:
        return Icons.calendar_today;
      case Tests.translation:
        return Icons.travel_explore_rounded;
    }
  }
}
