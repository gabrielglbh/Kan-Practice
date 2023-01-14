import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';

/// TODO when updating:
/// When adding a new grammar mode, be sure to update [WordListFilter, TestHistoryFilters] too
/// Be aware of changing the stats page and bloc to match the newly created mode
enum GrammarModes { definition, grammarPoints }

extension GrammarModesExt on GrammarModes {
  String get mode {
    switch (this) {
      case GrammarModes.definition:
        return "study_modes_definition".tr();
      case GrammarModes.grammarPoints:
        return "study_modes_grammarPoints".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case GrammarModes.definition:
        return Icons.school_rounded;
      case GrammarModes.grammarPoints:
        return Icons.translate_rounded;
    }
  }

  String get japMode {
    switch (this) {
      case GrammarModes.definition:
        return "study_modes_definition_ext".tr();
      case GrammarModes.grammarPoints:
        return "study_modes_grammarPoints_ext".tr();
    }
  }

  Color get color {
    switch (this) {
      case GrammarModes.definition:
        return Colors.indigo.shade300;
      case GrammarModes.grammarPoints:
        return Colors.pink.shade300;
    }
  }

  String get page {
    switch (this) {
      case GrammarModes.definition:
        return KanPracticePages.definitionStudyPage;
      case GrammarModes.grammarPoints:
        return KanPracticePages.grammarPointStudyPage;
    }
  }
}
