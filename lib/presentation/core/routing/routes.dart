import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/dictionary/dict_bloc.dart';
import 'package:kanpractice/application/list_details/list_details_bloc.dart';
import 'package:kanpractice/application/study_mode/study_mode_bloc.dart';
import 'package:kanpractice/application/word_history/word_history_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/presentation/account_login_page/account_login_page.dart';
import 'package:kanpractice/presentation/add_folder_page/add_folder_page.dart';
import 'package:kanpractice/presentation/add_market_list_page/add_market_list_page.dart';
import 'package:kanpractice/presentation/add_word_page/add_word_page.dart';
import 'package:kanpractice/presentation/add_word_page/arguments.dart';
import 'package:kanpractice/presentation/backup_page/backup_page.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';
import 'package:kanpractice/presentation/dictionary_details_page/dictionary_details_page.dart';
import 'package:kanpractice/presentation/dictionary_page/arguments.dart';
import 'package:kanpractice/presentation/dictionary_page/dictionary_page.dart';
import 'package:kanpractice/presentation/folder_details_page/folder_details_page.dart';
import 'package:kanpractice/presentation/home_page/home_page.dart';
import 'package:kanpractice/presentation/list_details_page/list_details_page.dart';
import 'package:kanpractice/presentation/statistics_page/statistics_page.dart';
import 'package:kanpractice/presentation/statistics_page/tab/test_history_tab/test_history_filters.dart';
import 'package:kanpractice/presentation/statistics_page/tab/test_history_tab/test_history_landscape.dart';
import 'package:kanpractice/presentation/statistics_page/tab/test_history_tab/test_history_tab.dart';
import 'package:kanpractice/presentation/study_modes/listening_page.dart';
import 'package:kanpractice/presentation/study_modes/reading_page.dart';
import 'package:kanpractice/presentation/study_modes/recognition_page.dart';
import 'package:kanpractice/presentation/study_modes/speaking_page.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';
import 'package:kanpractice/presentation/study_modes/writing_page.dart';
import 'package:kanpractice/presentation/test_result_page/arguments.dart';
import 'package:kanpractice/presentation/test_result_page/test_result_page.dart';
import 'package:kanpractice/presentation/word_history_page/word_history_page.dart';
import 'package:page_transition/page_transition.dart';

/// Router generator in which all pages and their transitions are made.
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case KanPracticePages.homePage:
      bool? showTestBottomSheet = settings.arguments as bool?;
      return CupertinoPageRoute(
          builder: (_) => HomePage(showTestBottomSheet: showTestBottomSheet));
    case KanPracticePages.kanjiListDetailsPage:
      WordList list = settings.arguments as WordList;
      return CupertinoPageRoute(
          builder: (_) => BlocProvider<ListDetailBloc>(
              create: (_) => getIt<ListDetailBloc>()
                ..add(ListDetailEventLoading(list.name)),
              child: ListDetailsPage(list: list)));
    case KanPracticePages.addKanjiPage:
      AddWordArgs args = settings.arguments as AddWordArgs;
      return CupertinoPageRoute(builder: (_) => AddWordPage(args: args));
    case KanPracticePages.writingStudyPage:
      ModeArguments args = settings.arguments as ModeArguments;
      return CupertinoPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => getIt<StudyModeBloc>(),
                child: WritingStudy(args: args),
              ));
    case KanPracticePages.readingStudyPage:
      ModeArguments args = settings.arguments as ModeArguments;
      return CupertinoPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => getIt<StudyModeBloc>(),
                child: ReadingStudy(args: args),
              ));
    case KanPracticePages.recognitionStudyPage:
      ModeArguments args = settings.arguments as ModeArguments;
      return CupertinoPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => getIt<StudyModeBloc>(),
                child: RecognitionStudy(args: args),
              ));
    case KanPracticePages.listeningStudyPage:
      ModeArguments args = settings.arguments as ModeArguments;
      return CupertinoPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => getIt<StudyModeBloc>(),
                child: ListeningStudy(args: args),
              ));
    case KanPracticePages.speakingStudyPage:
      ModeArguments args = settings.arguments as ModeArguments;
      return CupertinoPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => getIt<StudyModeBloc>(),
                child: SpeakingStudy(args: args),
              ));
    case KanPracticePages.testResultPage:
      TestResultArguments args = settings.arguments as TestResultArguments;
      return CupertinoPageRoute(builder: (_) => TestResultPage(args: args));
    case KanPracticePages.loginPage:
      return CupertinoPageRoute(builder: (_) => const LoginPage());
    case KanPracticePages.backUpPage:
      String args = settings.arguments as String;
      return CupertinoPageRoute(builder: (_) => BackUpPage(uid: args));
    case KanPracticePages.jishoPage:
      DictionaryDetailsArguments args =
          settings.arguments as DictionaryDetailsArguments;
      return PageTransition(
          type: PageTransitionType.bottomToTop,
          child: DictionaryDetailsPage(args: args));
    case KanPracticePages.dictionaryPage:
      DictionaryArguments args = settings.arguments as DictionaryArguments;
      return CupertinoPageRoute(
          builder: (_) => BlocProvider<DictBloc>(
                create: (context) => getIt<DictBloc>(),
                child: DictionaryPage(args: args),
              ));
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
          builder: (_) => FolderDetailsPage(folder: folder));
    case KanPracticePages.historyWordPage:
      return CupertinoPageRoute(
          builder: (_) => BlocProvider<WordHistoryBloc>(
              create: (_) => getIt<WordHistoryBloc>()
                ..add(const WordHistoryEventLoading()),
              child: const WordHistoryPage()));
    case KanPracticePages.historyTestExpandedPage:
      return CupertinoPageRoute(builder: (_) {
        TestHistoryArgs data = settings.arguments as TestHistoryArgs;
        return TestHistoryExpanded(data: data);
      });
    case KanPracticePages.historyTestFiltersPage:
      return CupertinoPageRoute(builder: (_) {
        TestHistoryArgs data = settings.arguments as TestHistoryArgs;
        return TestHistoryFilters(data: data);
      });
  }
  return null;
}