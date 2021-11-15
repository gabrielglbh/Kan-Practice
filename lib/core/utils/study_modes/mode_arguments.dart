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

  int get map {
    switch(this) {
      case StudyModes.writing:
        return 0;
      case StudyModes.reading:
        return 1;
      case StudyModes.recognition:
        return 2;
    }
  }
}

class StudyModesUtil {
  /// Maps the integer received from the source to a StudyModes. Based on [map]
  static mapStudyMode(int map) {
    switch(map) {
      case 0:
        return StudyModes.writing;
      case 1:
        return StudyModes.reading;
      case 2:
        return StudyModes.recognition;
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