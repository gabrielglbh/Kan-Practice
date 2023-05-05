import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kanpractice/application/add_word/add_word_bloc.dart';
import 'package:kanpractice/application/alter_specific_data/alter_specific_data_bloc.dart';
import 'package:kanpractice/application/archive_grammar_points/archive_grammar_points_bloc.dart';
import 'package:kanpractice/application/archive_words/archive_words_bloc.dart';
import 'package:kanpractice/application/auth/auth_bloc.dart';
import 'package:kanpractice/application/backup/backup_bloc.dart';
import 'package:kanpractice/application/daily_options/daily_options_bloc.dart';
import 'package:kanpractice/application/example_data/example_data_bloc.dart';
import 'package:kanpractice/application/folder_details/folder_details_bloc.dart';
import 'package:kanpractice/application/folder_list/folder_bloc.dart';
import 'package:kanpractice/application/generic_test/generic_test_bloc.dart';
import 'package:kanpractice/application/grammar_mode/grammar_mode_bloc.dart';
import 'package:kanpractice/application/grammar_test/grammar_test_bloc.dart';
import 'package:kanpractice/application/list_details_grammar_points/list_details_grammar_points_bloc.dart';
import 'package:kanpractice/application/list_details_words/list_details_words_bloc.dart';
import 'package:kanpractice/application/lists/lists_bloc.dart';
import 'package:kanpractice/application/market/market_bloc.dart';
import 'package:kanpractice/application/sentence_generator/sentence_generator_bloc.dart';
import 'package:kanpractice/application/services/messaging_service.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/application/specific_data/specific_data_bloc.dart';
import 'package:kanpractice/application/study_mode/study_mode_bloc.dart';
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
  if (prefs.readData(SharedKeys.numberOfWordInTest) == null) {
    prefs.saveData(SharedKeys.numberOfWordInTest, KPSizes.numberOfWordInTest);
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
  if (prefs.readData(SharedKeys.definitionDailyNotification) == null) {
    prefs.saveData(SharedKeys.definitionDailyNotification, true);
  }
  if (prefs.readData(SharedKeys.grammarPointDailyNotification) == null) {
    prefs.saveData(SharedKeys.grammarPointDailyNotification, true);
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
  if (prefs.readData(SharedKeys.showBadgeWords) == null) {
    prefs.saveData(SharedKeys.showBadgeWords, false);
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

      /// For users that already have the tutorial done
      getIt<DailyOptionsBloc>().add(DailyOptionsEventLoadData());
      if (getIt<PreferencesService>()
              .readData(SharedKeys.haveSeenKanListCoachMark) ==
          false) {
        getIt<ExampleDataBloc>().add(ExampleDataEventInstallData(context));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ExampleDataBloc>()),
        BlocProvider(create: (_) => getIt<ListsBloc>()),
        BlocProvider(create: (_) => getIt<FolderBloc>()),
        BlocProvider(create: (_) => getIt<BackupBloc>()),
        BlocProvider(create: (_) => getIt<MarketBloc>()),
        BlocProvider(create: (_) => getIt<StudyModeBloc>()),
        BlocProvider(create: (_) => getIt<AuthBloc>()..add(AuthIdle())),
        BlocProvider(create: (_) => getIt<GenericTestBloc>()),
        BlocProvider(create: (_) => getIt<FolderDetailsBloc>()),
        BlocProvider(create: (_) => getIt<SpecificDataBloc>()),
        BlocProvider(create: (_) => getIt<AlterSpecificDataBloc>()),
        BlocProvider(create: (_) => getIt<ListDetailsWordsBloc>()),
        BlocProvider(create: (_) => getIt<ListDetailsGrammarPointsBloc>()),
        BlocProvider(create: (_) => getIt<GrammarModeBloc>()),
        BlocProvider(create: (_) => getIt<GrammarTestBloc>()),
        BlocProvider(create: (_) => getIt<ArchiveGrammarPointsBloc>()),
        BlocProvider(create: (_) => getIt<ArchiveWordsBloc>()),
        BlocProvider(create: (_) => getIt<AddWordBloc>()),
        BlocProvider(create: (_) => getIt<DailyOptionsBloc>()),
        BlocProvider(create: (_) => getIt<SentenceGeneratorBloc>()),
      ],
      child: BlocListener<ExampleDataBloc, ExampleDataState>(
        listener: (context, state) {
          state.mapOrNull(loaded: (_) {
            getIt<DailyOptionsBloc>().add(DailyOptionsEventLoadData());
          });
        },
        child: MaterialApp(
          title: 'KanPractice Pro',
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.instance.currentLightThemeData,
          darkTheme: ThemeManager.instance.currentDarkThemeData,
          themeMode: ThemeManager.instance.themeMode,
          initialRoute: KanPracticePages.homePage,
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }
}
