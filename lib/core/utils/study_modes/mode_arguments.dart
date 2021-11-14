import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';

enum StudyModes { writing, reading, recognition }

extension StudyModesExt on StudyModes {
  String get mode {
    switch(this) {
      case StudyModes.writing:
        return "Writing";
      case StudyModes.reading:
        return "Reading";
      case StudyModes.recognition:
        return "Recognition";
    }
  }

  String get japMode {
    switch(this) {
      case StudyModes.writing:
        return "書く";
      case StudyModes.reading:
        return "読む";
      case StudyModes.recognition:
        return "認識";
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