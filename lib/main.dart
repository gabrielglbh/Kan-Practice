import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/kanji_lists/widgets/KanListTile.dart';
import 'package:kanpractice/ui/theme/theme_manager.dart';
import 'core/routing/routes.dart';

Future<void> _initSharedPreferences() async {
  await StorageManager.getInstance();
  if (StorageManager.readData(StorageManager.hasDoneTutorial) == null)
    StorageManager.saveData(StorageManager.hasDoneTutorial, false);
  if (StorageManager.readData(StorageManager.affectOnPractice) == null)
    StorageManager.saveData(StorageManager.affectOnPractice, false);
  if (StorageManager.readData(StorageManager.kanListGraphVisualization) == null)
    StorageManager.saveData(StorageManager.kanListGraphVisualization, VisualizationMode.radialChart.name);
  /// Make the value the same as hasDoneTutorial. If the user has already seen
  /// the overall tutorial, do not show the coach mark tutorial
  // DEBUG ONLY
  //StorageManager.saveData(StorageManager.haveSeenKanListCoachMark, false);
  //StorageManager.saveData(StorageManager.haveSeenKanListDetailCoachMark, false);
  bool hasDoneTutorial = StorageManager.readData(StorageManager.hasDoneTutorial);
  if (StorageManager.readData(StorageManager.haveSeenKanListCoachMark) == null)
    StorageManager.saveData(StorageManager.haveSeenKanListCoachMark, hasDoneTutorial);
  if (StorageManager.readData(StorageManager.haveSeenKanListDetailCoachMark) == null)
    StorageManager.saveData(StorageManager.haveSeenKanListDetailCoachMark, hasDoneTutorial);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initSharedPreferences();
  await CustomDatabase.instance.open();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(SetUpApp());
}

class SetUpApp extends StatelessWidget {
  const SetUpApp();

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: [
        Locale("en"),
        Locale("es"),
        Locale("de"),
      ],
      path: "lib/core/localization",
      fallbackLocale: Locale("en"),
      child: KanPractice(),
    );
  }
}

class KanPractice extends StatefulWidget {
  const KanPractice();

  @override
  _KanPracticeState createState() => _KanPracticeState();
}

class _KanPracticeState extends State<KanPractice> {

  @override
  void initState() {
    ThemeManager.instance.addListenerTo(() => setState(() {}));
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
      initialRoute: StorageManager.readData(StorageManager.hasDoneTutorial)
          ? KanPracticePages.kanjiListPage : KanPracticePages.tutorialPage,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
