import 'package:flutter/cupertino.dart';
import 'package:kanpractice/presentation/account_management_page/account_managament_page.dart';
import 'package:kanpractice/presentation/add_grammar_point_page/add_grammar_point_page.dart';
import 'package:kanpractice/presentation/add_grammar_point_page/arguments.dart';
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
import 'package:kanpractice/presentation/grammar_modes/definition_page.dart';
import 'package:kanpractice/presentation/grammar_modes/grammar_point_page.dart';
import 'package:kanpractice/presentation/grammar_modes/utils/grammar_mode_arguments.dart';
import 'package:kanpractice/presentation/home_page/home_page.dart';
import 'package:kanpractice/presentation/list_details_page/list_details_page.dart';
import 'package:kanpractice/presentation/market_page/market_page.dart';
import 'package:kanpractice/presentation/ocr_page/ocr_page.dart';
import 'package:kanpractice/presentation/settings_daily_options_page/settings_daily_options_page.dart';
import 'package:kanpractice/presentation/settings_toggle_page/settings_toggle_page.dart';
import 'package:kanpractice/presentation/statistics_page/statistics_page.dart';
import 'package:kanpractice/presentation/statistics_page/tab/test_history_tab/test_history_filters.dart';
import 'package:kanpractice/presentation/statistics_page/tab/test_history_tab/test_history_landscape.dart';
import 'package:kanpractice/presentation/statistics_page/tab/test_history_tab/test_history_tab.dart';
import 'package:kanpractice/presentation/store_page/store_page.dart';
import 'package:kanpractice/presentation/study_modes/listening_page.dart';
import 'package:kanpractice/presentation/study_modes/reading_page.dart';
import 'package:kanpractice/presentation/study_modes/recognition_page.dart';
import 'package:kanpractice/presentation/study_modes/speaking_page.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';
import 'package:kanpractice/presentation/study_modes/writing_page.dart';
import 'package:kanpractice/presentation/test_result_page/arguments.dart';
import 'package:kanpractice/presentation/test_result_page/test_result_page.dart';
import 'package:kanpractice/presentation/translation_test_page/translation_test_page.dart';
import 'package:kanpractice/presentation/word_history_page/word_history_page.dart';
import 'package:page_transition/page_transition.dart';

/// Router generator in which all pages and their transitions are made.
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case KanPracticePages.homePage:
      bool? showTestBottomSheet = settings.arguments as bool?;
      return CupertinoPageRoute(
          builder: (_) => HomePage(showTestBottomSheet: showTestBottomSheet));
    case KanPracticePages.wordListDetailsPage:
      WordList list = settings.arguments as WordList;
      return CupertinoPageRoute(builder: (_) => ListDetailsPage(list: list));
    case KanPracticePages.addWordPage:
      AddWordArgs args = settings.arguments as AddWordArgs;
      return CupertinoPageRoute(builder: (_) => AddWordPage(args: args));
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
    case KanPracticePages.definitionStudyPage:
      GrammarModeArguments args = settings.arguments as GrammarModeArguments;
      return CupertinoPageRoute(builder: (_) => DefinitionStudy(args: args));
    case KanPracticePages.grammarPointStudyPage:
      GrammarModeArguments args = settings.arguments as GrammarModeArguments;
      return CupertinoPageRoute(builder: (_) => GrammarPointStudy(args: args));
    case KanPracticePages.testResultPage:
      TestResultArguments args = settings.arguments as TestResultArguments;
      return CupertinoPageRoute(builder: (_) => TestResultPage(args: args));
    case KanPracticePages.loginPage:
      String? productId = settings.arguments as String?;
      return CupertinoPageRoute(
          builder: (_) => LoginPage(productId: productId));
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
      return CupertinoPageRoute(builder: (_) => DictionaryPage(args: args));
    case KanPracticePages.statisticsPage:
      return CupertinoPageRoute(builder: (_) => const StatisticsPage());
    case KanPracticePages.marketAddListPage:
      return CupertinoPageRoute(builder: (_) => const AddMarketListPage());
    case KanPracticePages.folderAddPage:
      String? folder = settings.arguments as String?;
      return CupertinoPageRoute(builder: (_) => AddFolderPage(folder: folder));
    case KanPracticePages.wordListOnFolderPage:
      String folder = settings.arguments as String;
      return CupertinoPageRoute(
          builder: (_) => FolderDetailsPage(folder: folder));
    case KanPracticePages.historyWordPage:
      return CupertinoPageRoute(builder: (_) => const WordHistoryPage());
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
    case KanPracticePages.settingsTogglePage:
      return CupertinoPageRoute(builder: (_) {
        return const SettingsTogglePage();
      });
    case KanPracticePages.settingsDailyOptions:
      return CupertinoPageRoute(builder: (_) {
        return const SettingsDailyOptionsPage();
      });
    case KanPracticePages.addGrammarPage:
      AddGrammarPointArgs args = settings.arguments as AddGrammarPointArgs;
      return CupertinoPageRoute(builder: (_) => AddGrammarPage(args: args));
    case KanPracticePages.marketPage:
      return CupertinoPageRoute(builder: (_) {
        return const MarketPage();
      });
    case KanPracticePages.storePage:
      return CupertinoPageRoute(builder: (_) {
        return const StorePage();
      });
    case KanPracticePages.translationsTestPage:
      ModeArguments args = settings.arguments as ModeArguments;
      return CupertinoPageRoute(
          builder: (_) => TranslationTestPage(args: args));
    case KanPracticePages.ocrPage:
      return CupertinoPageRoute(builder: (_) => const OCRPage());
    case KanPracticePages.accountManagementPage:
      return CupertinoPageRoute(builder: (_) => const AccountManagementPage());
  }
  return null;
}
