import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';

/// TODO When adding a new grammar mode, be sure to update [GrammarModeFilters] too
enum GrammarModes { definition }

extension GrammarModesExt on GrammarModes {
  String get mode {
    switch (this) {
      case GrammarModes.definition:
        return "study_modes_definition".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case GrammarModes.definition:
        return Icons.school_rounded;
    }
  }

  String get japMode {
    switch (this) {
      case GrammarModes.definition:
        return "study_modes_definition_ext".tr();
    }
  }

  Color get color {
    switch (this) {
      case GrammarModes.definition:
        return Colors.indigo.shade300;
    }
  }

  String get page {
    switch (this) {
      case GrammarModes.definition:
        return KanPracticePages.definitionStudyPage;
    }
  }
}
