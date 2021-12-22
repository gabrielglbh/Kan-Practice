import 'package:flutter/material.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/tutorial/widgets/BulletPageView.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:easy_localization/easy_localization.dart';

enum TutorialView {
  kanList, list, details, jisho, practicing, options
}

extension TestPagesExt on TutorialView {
  String get tutorial {
    switch (this) {
      case TutorialView.kanList:
        return "tutorial_kanlist".tr();
      case TutorialView.list:
        return "tutorial_lists".tr();
      case TutorialView.details:
        return "tutorial_details".tr();
      case TutorialView.jisho:
        return "tutorial_jisho".tr();
      case TutorialView.practicing:
        return "tutorial_practicing".tr();
      case TutorialView.options:
        return "tutorial_options".tr();
    }
  }

  String asset({bool lightMode = true}) {
    switch (this) {
      case TutorialView.kanList:
        if (lightMode) return "assets/tutorial/light/kanlist.png";
        else return "assets/tutorial/dark/kanlist.png";
      case TutorialView.list:
        if (lightMode) return "assets/tutorial/light/list.png";
        else return "assets/tutorial/dark/list.png";
      case TutorialView.details:
        if (lightMode) return "assets/tutorial/light/details.png";
        else return "assets/tutorial/dark/details.png";
      case TutorialView.jisho:
        if (lightMode) return "assets/tutorial/light/jisho.png";
        else return "assets/tutorial/dark/jisho.png";
      case TutorialView.practicing:
        if (lightMode) return "assets/tutorial/light/practice.png";
        else return "assets/tutorial/dark/practice.png";
      case TutorialView.options:
        if (lightMode) return "assets/tutorial/light/options.png";
        else return "assets/tutorial/dark/options.png";
    }
  }
}

class TutorialPage extends StatefulWidget {
  final bool? alreadyShown;
  TutorialPage({this.alreadyShown});

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  bool _showSkip = true;

  _onEnd(BuildContext context) {
    if (widget.alreadyShown == null) {
      StorageManager.saveData(StorageManager.hasDoneTutorial, true);
      Navigator.of(context).pushReplacementNamed(KanPracticePages.kanjiListPage);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomSizes.appBarHeight,
        actions: [
          TextButton(
            onPressed: () => _onEnd(context),
            child: Text(_showSkip ? "tutorial_skip".tr() : "tutorial_done".tr(),
              style: TextStyle(color: CustomColors.secondarySubtleColor),
            )
          )
        ],
      ),
      body: BulletPageView(
        bullets: TutorialView.values.length,
        onChanged: (newPage) => setState(() => _showSkip = newPage != TutorialView.values.length - 1),
        pageViewChildren: [
          _tutorialPage(context, TutorialView.kanList),
          _tutorialPage(context, TutorialView.list),
          _tutorialPage(context, TutorialView.details),
          _tutorialPage(context, TutorialView.jisho),
          _tutorialPage(context, TutorialView.practicing),
          _tutorialPage(context, TutorialView.options),
        ],
      )
    );
  }

  Column _tutorialPage(BuildContext context, TutorialView view) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(Margins.margin8),
            child: SingleChildScrollView(child: Text(view.tutorial, textAlign: TextAlign.center)),
          )
        ),
        Expanded(
          flex: 5,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(Margins.margin8),
            margin: EdgeInsets.symmetric(horizontal: Margins.margin8),
            child: FittedBox(
              fit: view == TutorialView.jisho ? BoxFit.fitWidth : BoxFit.fitHeight,
              child: Image.asset(view.asset(lightMode: Theme.of(context).brightness == Brightness.light))
            ),
          ),
        ),
      ],
    );
  }
}
