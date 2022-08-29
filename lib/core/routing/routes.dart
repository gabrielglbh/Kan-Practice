import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/add_folder/add_folder.dart';
import 'package:kanpractice/ui/pages/add_kanji/add_kanji.dart';
import 'package:kanpractice/ui/pages/add_kanji/arguments.dart';
import 'package:kanpractice/ui/pages/add_market_list/add_market_list.dart';
import 'package:kanpractice/ui/pages/backup/backup.dart';
import 'package:kanpractice/ui/pages/dictionary/arguments.dart';
import 'package:kanpractice/ui/pages/dictionary/dictionary.dart';
import 'package:kanpractice/ui/pages/firebase_login/login.dart';
import 'package:kanpractice/ui/pages/home/home.dart';
import 'package:kanpractice/ui/pages/jisho/arguments.dart';
import 'package:kanpractice/ui/pages/jisho/jisho.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/bloc/details_bloc.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/list_details.dart';
import 'package:kanpractice/ui/pages/kanji_list_on_folder/kanji_list_on_folder.dart';
import 'package:kanpractice/ui/pages/study_modes/listening.dart';
import 'package:kanpractice/ui/pages/study_modes/reading.dart';
import 'package:kanpractice/ui/pages/study_modes/recognition.dart';
import 'package:kanpractice/ui/pages/settings/settings.dart';
import 'package:kanpractice/ui/pages/statistics/statistics.dart';
import 'package:kanpractice/ui/pages/study_modes/speaking.dart';
import 'package:kanpractice/ui/pages/study_modes/utils/mode_arguments.dart';
import 'package:kanpractice/ui/pages/test_history/bloc/test_bloc.dart';
import 'package:kanpractice/ui/pages/test_history/test_history.dart';
import 'package:kanpractice/ui/pages/test_result/arguments.dart';
import 'package:kanpractice/ui/pages/test_result/test_result.dart';
import 'package:kanpractice/ui/pages/tutorial/tutorial.dart';
import 'package:kanpractice/ui/pages/study_modes/writing.dart';
import 'package:kanpractice/ui/pages/word_history/bloc/word_history_bloc.dart';
import 'package:kanpractice/ui/pages/word_history/word_history.dart';
import 'package:page_transition/page_transition.dart';

/// Router generator in which all pages and their transitions are made.
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case KanPracticePages.homePage:
      bool? showTestBottomSheet = settings.arguments as bool?;
      return CupertinoPageRoute(
          builder: (_) => HomePage(showTestBottomSheet: showTestBottomSheet));
    case KanPracticePages.kanjiListDetailsPage:
      KanjiList list = settings.arguments as KanjiList;
      return CupertinoPageRoute(
          builder: (_) => BlocProvider<KanjiListDetailBloc>(
              create: (_) =>
                  KanjiListDetailBloc()..add(KanjiEventLoading(list.name)),
              child: KanjiListDetails(list: list)));
    case KanPracticePages.settingsPage:
      return CupertinoPageRoute(builder: (_) => const Settings());
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
    case KanPracticePages.listeningStudyPage:
      ModeArguments args = settings.arguments as ModeArguments;
      return CupertinoPageRoute(builder: (_) => ListeningStudy(args: args));
    case KanPracticePages.speakingStudyPage:
      ModeArguments args = settings.arguments as ModeArguments;
      return CupertinoPageRoute(builder: (_) => SpeakingStudy(args: args));
    case KanPracticePages.testResultPage:
      TestResultArguments args = settings.arguments as TestResultArguments;
      return CupertinoPageRoute(builder: (_) => TestResult(args: args));
    case KanPracticePages.testHistoryPage:
      return CupertinoPageRoute(
          builder: (_) => BlocProvider<TestListBloc>(
              create: (_) => TestListBloc()..add(const TestListEventLoading()),
              child: const TestHistory()));
    case KanPracticePages.loginPage:
      return CupertinoPageRoute(builder: (_) => const LoginPage());
    case KanPracticePages.backUpPage:
      String args = settings.arguments as String;
      return CupertinoPageRoute(builder: (_) => BackUpPage(uid: args));
    case KanPracticePages.tutorialPage:
      bool? args = settings.arguments as bool?;
      return CupertinoPageRoute(
          builder: (_) => TutorialPage(alreadyShown: args));
    case KanPracticePages.jishoPage:
      JishoArguments args = settings.arguments as JishoArguments;
      return PageTransition(
          type: PageTransitionType.bottomToTop, child: JishoPage(args: args));
    case KanPracticePages.dictionaryPage:
      DictionaryArguments args = settings.arguments as DictionaryArguments;
      return CupertinoPageRoute(builder: (_) => DictionaryPage(args: args));
    case KanPracticePages.statisticsPage:
      return CupertinoPageRoute(builder: (_) => const StatisticsPage());
    case KanPracticePages.marketAddListPage:
      return CupertinoPageRoute(builder: (_) => const AddMarketListPage());
    case KanPracticePages.folderAddPage:
      String? folder = settings.arguments as String?;
      return CupertinoPageRoute(builder: (_) => AddFolderPage(folder: folder));
    case KanPracticePages.kanjiListOnFolderPage:
      String folder = settings.arguments as String;
      return CupertinoPageRoute(
          builder: (_) => KanListOnFolderPage(folder: folder));
    case KanPracticePages.historyWordPage:
      return CupertinoPageRoute(
          builder: (_) => BlocProvider<WordHistoryBloc>(
              create: (_) =>
                  WordHistoryBloc()..add(const WordHistoryEventLoading()),
              child: const WordHistoryPage()));
  }
  return null;
}
