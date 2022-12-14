import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kanpractice/application/add_folder/add_folder_bloc.dart';
import 'package:kanpractice/application/add_market_list/add_to_market_bloc.dart';
import 'package:kanpractice/application/add_word/add_word_bloc.dart';
import 'package:kanpractice/application/auth/auth_bloc.dart';
import 'package:kanpractice/application/backup/backup_bloc.dart';
import 'package:kanpractice/application/dictionary/dict_bloc.dart';
import 'package:kanpractice/application/dictionary_details/dictionary_details_bloc.dart';
import 'package:kanpractice/application/folder_details/folder_details_bloc.dart';
import 'package:kanpractice/application/folder_list/folder_bloc.dart';
import 'package:kanpractice/application/initial/initial_bloc.dart';
import 'package:kanpractice/application/list/lists_bloc.dart';
import 'package:kanpractice/application/list_details/list_details_bloc.dart';
import 'package:kanpractice/application/load_folder_practice/load_folder_practice_bloc.dart';
import 'package:kanpractice/application/load_test/load_test_bloc.dart';
import 'package:kanpractice/application/load_test_category_selection/load_test_category_selection_bloc.dart';
import 'package:kanpractice/application/load_test_folder_selection/load_test_folder_selection_bloc.dart';
import 'package:kanpractice/application/load_test_list_selection/load_test_list_selection_bloc.dart';
import 'package:kanpractice/application/market/market_bloc.dart';
import 'package:kanpractice/application/rate/rate_bloc.dart';
import 'package:kanpractice/application/services/messaging_service.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/application/settings/settings_bloc.dart';
import 'package:kanpractice/application/specific_data/specific_data_bloc.dart';
import 'package:kanpractice/application/statistics/stats_bloc.dart';
import 'package:kanpractice/application/study_mode/study_mode_bloc.dart';
import 'package:kanpractice/application/test_history/test_history_bloc.dart';
import 'package:kanpractice/application/test_result/test_result_bloc.dart';
import 'package:kanpractice/application/word_details/word_details_bloc.dart';
import 'package:kanpractice/application/word_history/word_history_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/theme/theme_manager.dart';
import 'presentation/core/routing/routes.dart';

Future<void> _initSharedPreferences() async {
  final prefs = getIt<PreferencesService>();
  if (prefs.readData(SharedKeys.affectOnPractice) == null) {
    prefs.saveData(SharedKeys.affectOnPractice, false);
  }
  if (prefs.readData(SharedKeys.kanListListVisualization) == null) {
    prefs.saveData(SharedKeys.kanListListVisualization, false);
  }
  if (prefs.readData(SharedKeys.numberOfKanjiInTest) == null) {
    prefs.saveData(SharedKeys.numberOfKanjiInTest, KPSizes.numberOfKanjiInTest);
  }
  if (prefs.readData(SharedKeys.enableRepetitionOnTests) == null) {
    prefs.saveData(SharedKeys.enableRepetitionOnTests, true);
  }

  /// Breaking change with 2.1.0: if themeMode in shared preferences is bool
  /// then change it to the actual name of [ThemeMode], as [ThemeMode.system]
  /// is introduced
  var theme = prefs.readData(SharedKeys.themeMode);
  if (theme is bool) {
    prefs.saveData(SharedKeys.themeMode,
        theme ? ThemeMode.dark.name : ThemeMode.light.name);
  }

  if (prefs.readData(SharedKeys.writingDailyNotification) == null) {
    prefs.saveData(SharedKeys.writingDailyNotification, true);
  }
  if (prefs.readData(SharedKeys.readingDailyNotification) == null) {
    prefs.saveData(SharedKeys.readingDailyNotification, true);
  }
  if (prefs.readData(SharedKeys.recognitionDailyNotification) == null) {
    prefs.saveData(SharedKeys.recognitionDailyNotification, true);
  }
  if (prefs.readData(SharedKeys.listeningDailyNotification) == null) {
    prefs.saveData(SharedKeys.listeningDailyNotification, true);
  }
  if (prefs.readData(SharedKeys.speakingDailyNotification) == null) {
    prefs.saveData(SharedKeys.speakingDailyNotification, true);
  }
  if (prefs.readData(SharedKeys.dailyTestOnControlledPace) == null) {
    prefs.saveData(SharedKeys.dailyTestOnControlledPace, false);
  }

  /// Make the value the same as hasDoneTutorial. If the user has already seen
  /// the overall tutorial, do not show the coach mark tutorial
  // DEBUG ONLY
  // prefs.saveData(SharedKeys.haveSeenKanListCoachMark, false);
  // prefs.saveData(SharedKeys.haveSeenKanListDetailCoachMark, false);
  if (prefs.readData(SharedKeys.haveSeenKanListCoachMark) == null) {
    prefs.saveData(SharedKeys.haveSeenKanListCoachMark, false);
  }
  if (prefs.readData(SharedKeys.haveSeenKanListDetailCoachMark) == null) {
    prefs.saveData(SharedKeys.haveSeenKanListDetailCoachMark, false);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  await _initSharedPreferences();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await FlutterLocalNotificationsPlugin().initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('splash'),
    ),
  );
  runApp(const SetUpApp());
}

class SetUpApp extends StatelessWidget {
  const SetUpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale("en"),
        Locale("es"),
        Locale("de"),
      ],
      path: "lib/presentation/core/localization",
      fallbackLocale: const Locale("en"),
      child: const KanPractice(),
    );
  }
}

class KanPractice extends StatefulWidget {
  const KanPractice({Key? key}) : super(key: key);

  @override
  State<KanPractice> createState() => _KanPracticeState();
}

class _KanPracticeState extends State<KanPractice> {
  @override
  void initState() {
    ThemeManager.instance.addListenerTo(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getIt<MessagingService>().handler(context);
      if (getIt<PreferencesService>()
              .readData(SharedKeys.haveSeenKanListCoachMark) ==
          false) {
        getIt<InitialBloc>().add(InitialEventInstallData(context));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<InitialBloc>()),
        BlocProvider(create: (_) => getIt<ListBloc>()),
        BlocProvider(create: (_) => getIt<FolderBloc>()),
        BlocProvider(create: (_) => getIt<BackUpBloc>()),
        BlocProvider(create: (_) => getIt<DictBloc>()),
        BlocProvider(create: (_) => getIt<MarketBloc>()),
        BlocProvider(create: (_) => getIt<SettingsBloc>()),
        BlocProvider(create: (_) => getIt<ListDetailBloc>()),
        BlocProvider(create: (_) => getIt<StudyModeBloc>()),
        BlocProvider(create: (_) => getIt<WordHistoryBloc>()),
        BlocProvider(create: (_) => getIt<AuthBloc>()..add(AuthIdle())),
        BlocProvider(create: (_) => getIt<AddFolderBloc>()),
        BlocProvider(create: (_) => getIt<AddToMarketBloc>()),
        BlocProvider(create: (_) => getIt<AddWordBloc>()),
        BlocProvider(create: (_) => getIt<WordDetailsBloc>()),
        BlocProvider(create: (_) => getIt<LoadTestCategorySelectionBloc>()),
        BlocProvider(create: (_) => getIt<LoadTestBloc>()),
        BlocProvider(create: (_) => getIt<DictionaryDetailsBloc>()),
        BlocProvider(create: (_) => getIt<FolderDetailsBloc>()),
        BlocProvider(create: (_) => getIt<LoadFolderPracticeBloc>()),
        BlocProvider(create: (_) => getIt<LoadTestFolderSelectionBloc>()),
        BlocProvider(create: (_) => getIt<LoadTestListSelectionBloc>()),
        BlocProvider(create: (_) => getIt<RateBloc>()),
        BlocProvider(create: (_) => getIt<StatisticsBloc>()),
        BlocProvider(create: (_) => getIt<TestHistoryBloc>()),
        BlocProvider(create: (_) => getIt<SpecificDataBloc>()),
        BlocProvider(create: (_) => getIt<TestResultBloc>()),
      ],
      child: BlocBuilder<InitialBloc, InitialState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'KanPractice',
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            theme: ThemeManager.instance.currentLightThemeData,
            darkTheme: ThemeManager.instance.currentDarkThemeData,
            themeMode: ThemeManager.instance.themeMode,
            initialRoute: KanPracticePages.homePage,
            onGenerateRoute: onGenerateRoute,
          );
        },
      ),
    );
  }
}
