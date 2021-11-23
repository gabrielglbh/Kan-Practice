import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/add_kanji/add_kanji.dart';
import 'package:kanpractice/ui/pages/add_kanji/arguments.dart';
import 'package:kanpractice/ui/pages/backup/backup.dart';
import 'package:kanpractice/ui/pages/firebase_login/login.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/list_details.dart';
import 'package:kanpractice/ui/pages/kanji_lists/kanji_lists.dart';
import 'package:kanpractice/ui/pages/reading/reading.dart';
import 'package:kanpractice/ui/pages/recognition/recognition.dart';
import 'package:kanpractice/ui/pages/settings/settings.dart';
import 'package:kanpractice/ui/pages/test_history/test_history.dart';
import 'package:kanpractice/ui/pages/test_result/arguments.dart';
import 'package:kanpractice/ui/pages/test_result/test_result.dart';
import 'package:kanpractice/ui/pages/tutorial/tutorial.dart';
import 'package:kanpractice/ui/pages/writing/writing.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';

/// Router generator in which all pages and their transitions are made.
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case KanPracticePages.kanjiListPage:
      return CupertinoPageRoute(builder: (_) => KanjiLists());
    case KanPracticePages.kanjiListDetailsPage:
      KanjiList list = settings.arguments as KanjiList;
      return CupertinoPageRoute(builder: (_) => KanjiListDetails(list: list));
    case KanPracticePages.settingsPage:
      return CupertinoPageRoute(builder: (_) => Settings());
    case KanPracticePages.addKanjiPage:
      AddKanjiArgs args = settings.arguments as AddKanjiArgs;
      return CupertinoPageRoute(builder: (_) => AddKanjiPage(args: args));
    case KanPracticePages.writingStudyPage:
      ModeArguments args = settings.arguments as ModeArguments;
      return CupertinoPageRoute(builder: (_) => WritingStudy(args: args));
    case KanPracticePages.readingStudyPage:
      ModeArguments args = settings.arguments as ModeArguments;
      return CupertinoPageRoute(builder: (_) => ReadingStudy(args: args));
    case KanPracticePages.recognitionStudyPage:
      ModeArguments args = settings.arguments as ModeArguments;
      return CupertinoPageRoute(builder: (_) => RecognitionStudy(args: args));
    case KanPracticePages.testResultPage:
      TestResultArguments args = settings.arguments as TestResultArguments;
      return CupertinoPageRoute(builder: (_) => TestResult(args: args));
    case KanPracticePages.testHistoryPage:
      return CupertinoPageRoute(builder: (_) => TestHistory());
    case KanPracticePages.loginPage:
      return CupertinoPageRoute(builder: (_) => LoginPage());
    case KanPracticePages.backUpPage:
      String args = settings.arguments as String;
      return CupertinoPageRoute(builder: (_) => BackUpPage(uid: args));
    case KanPracticePages.tutorialPage:
      bool? args = settings.arguments as bool?;
      return CupertinoPageRoute(builder: (_) => TutorialPage(alreadyShown: args));
  }
}