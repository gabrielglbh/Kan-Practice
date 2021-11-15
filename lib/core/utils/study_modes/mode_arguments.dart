import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:easy_localization/easy_localization.dart';

enum StudyModes { writing, reading, recognition }

extension StudyModesExt on StudyModes {
  String get mode {
    switch(this) {
      case StudyModes.writing:
        return "study_modes_writing".tr();
      case StudyModes.reading:
        return "study_modes_reading".tr();
      case StudyModes.recognition:
        return "study_modes_recognition".tr();
    }
  }

  String get japMode {
    switch(this) {
      case StudyModes.writing:
        return "study_modes_writing_ext".tr();
      case StudyModes.reading:
        return "study_modes_reading_ext".tr();
      case StudyModes.recognition:
        return "study_modes_recognition_ext".tr();
    }
  }

  Color get color {
    switch(this) {
      case StudyModes.writing:
        return Colors.blue[300]!;
      case StudyModes.reading:
        return Colors.purple[300]!;
      case StudyModes.recognition:
        return Colors.orange[300]!;
    }
  }
}

class ModeArguments {
  final List<Kanji> studyList;
  final bool isTest;
  final StudyModes mode;
  final String listsNames;

  ModeArguments({required this.studyList, required this.isTest, required this.mode, this.listsNames = ""});
}