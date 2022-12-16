import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';

/// TODO When adding a new grammar mode, be sure to update [GrammarModeFilters] too
enum GrammarModes { definition, recognition }

extension GrammarModesExt on GrammarModes {
  String get mode {
    switch (this) {
      case GrammarModes.definition:
        return "study_modes_definition".tr();
      case GrammarModes.recognition:
        return "study_modes_recognition".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case GrammarModes.definition:
        return Icons.school_rounded;
      case GrammarModes.recognition:
        return Icons.find_in_page_rounded;
    }
  }

  String get japMode {
    switch (this) {
      case GrammarModes.definition:
        return "study_modes_definition_ext".tr();
      case GrammarModes.recognition:
        return "study_modes_recognition_ext".tr();
    }
  }

  Color get color {
    switch (this) {
      case GrammarModes.definition:
        return Colors.indigo.shade300;
      case GrammarModes.recognition:
        return Colors.orange.shade300;
    }
  }

  String get page {
    switch (this) {
      // TODO: Create grammar mode practice page
      case GrammarModes.definition:
        return KanPracticePages.readingStudyPage;
      case GrammarModes.recognition:
        return KanPracticePages.recognitionStudyPage;
    }
  }
}
