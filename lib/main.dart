import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/theme/theme_manager.dart';

import 'core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.getInstance();
  await CustomDatabase.instance.open();
  await Firebase.initializeApp();
  runApp(KanPractice());
}

class KanPractice extends StatefulWidget {
  const KanPractice({Key? key}) : super(key: key);

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
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.instance.currentLightThemeData,
      darkTheme: ThemeManager.instance.currentDarkThemeData,
      themeMode: ThemeManager.instance.themeMode,
      initialRoute: kanjiListPage,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
