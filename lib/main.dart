import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/infrastructure/initial/initial_repository_impl.dart';
import 'package:kanpractice/infrastructure/services/messaging_repository_impl.dart';
import 'package:kanpractice/infrastructure/services/preferences_repository_impl.dart';
import 'package:kanpractice/infrastructure/test_data/test_data_repository_impl.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/theme/theme_manager.dart';
import 'presentation/core/routing/routes.dart';

Future<void> _initSharedPreferences() async {
  final prefs = getIt<PreferencesRepositoryImpl>();
  if (prefs.readData(SharedKeys.affectOnPractice) == null) {
    prefs.saveData(SharedKeys.affectOnPractice, false);
  }
  if (prefs.readData(SharedKeys.kanListListVisualization) == null) {
    prefs.saveData(SharedKeys.kanListListVisualization, false);
  }
  if (prefs.readData(SharedKeys.numberOfKanjiInTest) == null) {
    prefs.saveData(SharedKeys.numberOfKanjiInTest, KPSizes.numberOfKanjiInTest);
  }

  /// Breaking change with 2.1.0: if themeMode in shared preferences is bool
  /// then change it to the actual name of [ThemeMode], as [ThemeMode.system]
  /// is introduced
  var theme = prefs.readData(SharedKeys.themeMode);
  if (theme is bool) {
    prefs.saveData(SharedKeys.themeMode,
        theme ? ThemeMode.dark.name : ThemeMode.light.name);
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
  configureInjection();
  await _initSharedPreferences();
  await CustomDatabase.instance.open();
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
      path: "lib/core/localization",
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
      getIt<MessagingRepositoryImpl>().handler(context);
      if (getIt<PreferencesRepositoryImpl>()
              .readData(SharedKeys.haveSeenKanListCoachMark) ==
          false) {
        await getIt<InitialRepositoryImpl>()
            .setInitialDataForReference(context);
        await getIt<TestDataRepositoryImpl>().insertInitialTestData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    CustomDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
