import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/queries/initial_queries.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/core/firebase/queries/messaging.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/theme/theme_manager.dart';
import 'core/routing/routes.dart';

Future<void> _initSharedPreferences() async {
  await StorageManager.getInstance();
  if (StorageManager.readData(StorageManager.affectOnPractice) == null) {
    StorageManager.saveData(StorageManager.affectOnPractice, false);
  }
  if (StorageManager.readData(StorageManager.kanListListVisualization) ==
      null) {
    StorageManager.saveData(StorageManager.kanListListVisualization, false);
  }
  if (StorageManager.readData(StorageManager.numberOfKanjiInTest) == null) {
    StorageManager.saveData(
        StorageManager.numberOfKanjiInTest, KPSizes.numberOfKanjiInTest);
  }

  /// Breaking change with 2.1.0: if themeMode in shared preferences is bool
  /// then change it to the actual name of [ThemeMode], as [ThemeMode.system]
  /// is introduced
  var theme = StorageManager.readData(StorageManager.themeMode);
  if (theme is bool) {
    StorageManager.saveData(StorageManager.themeMode,
        theme ? ThemeMode.dark.name : ThemeMode.light.name);
  }

  /// Make the value the same as hasDoneTutorial. If the user has already seen
  /// the overall tutorial, do not show the coach mark tutorial
  // DEBUG ONLY
  //StorageManager.saveData(StorageManager.haveSeenKanListCoachMark, false);
  //StorageManager.saveData(StorageManager.haveSeenKanListDetailCoachMark, false);
  if (StorageManager.readData(StorageManager.haveSeenKanListCoachMark) ==
      null) {
    StorageManager.saveData(StorageManager.haveSeenKanListCoachMark, false);
  }
  if (StorageManager.readData(StorageManager.haveSeenKanListDetailCoachMark) ==
      null) {
    StorageManager.saveData(
        StorageManager.haveSeenKanListDetailCoachMark, false);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      MessagingHandler.handler(context);
      if (StorageManager.readData(StorageManager.haveSeenKanListCoachMark) ==
          false) {
        await InitialQueries.instance.setInitialDataForReference(context);
        await TestQueries.instance.insertInitialTestData();
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
