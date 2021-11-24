import 'package:flutter/material.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/tutorial/widgets/BulletPageView.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/ActionButton.dart';
import 'package:easy_localization/easy_localization.dart';

enum TutorialView {
  kanList, list, details, writing, reading, recognition, tests
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
      case TutorialView.writing:
        return "tutorial_writing".tr();
      case TutorialView.reading:
        return "tutorial_reading".tr();
      case TutorialView.recognition:
        return "tutorial_recognition".tr();
      case TutorialView.tests:
        return "tutorial_tests".tr();
    }
  }

  String get asset {
    switch (this) {
      case TutorialView.kanList:
        return "assets/tutorial/kanLists.png";
      case TutorialView.list:
        return "assets/tutorial/lists.png";
      case TutorialView.details:
        return "assets/tutorial/details.png";
      case TutorialView.writing:
        return "assets/tutorial/writing.png";
      case TutorialView.reading:
        return "assets/tutorial/reading.png";
      case TutorialView.recognition:
        return "assets/tutorial/recognition.png";
      case TutorialView.tests:
        return "assets/tutorial/tests.png";
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
      backgroundColor: CustomColors.secondaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BulletPageView(
              bullets: TutorialView.values.length,
              onChanged: (newPage) => setState(() => _showSkip = newPage != TutorialView.values.length - 1),
              pageViewChildren: [
                _tutorialPage(context, TutorialView.kanList),
                _tutorialPage(context, TutorialView.list),
                _tutorialPage(context, TutorialView.details),
                _tutorialPage(context, TutorialView.writing),
                _tutorialPage(context, TutorialView.reading),
                _tutorialPage(context, TutorialView.recognition),
                _tutorialPage(context, TutorialView.tests),
              ],
            ),
            ActionButton(
              label: _showSkip ? "tutorial_skip".tr() : "tutorial_done".tr(),
              color: Colors.white,
              textColor: Colors.black,
              onTap: () => _onEnd(context)
            ),
          ],
        )
      )
    );
  }

  Column _tutorialPage(BuildContext context, TutorialView view) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.25,
          decoration: BoxDecoration(
            color: CustomColors.secondarySubtleColor,
            borderRadius: BorderRadius.circular(CustomRadius.radius32)
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Image.asset(view.asset)
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Text(view.tutorial, style: TextStyle(color: Colors.white, fontSize: 16))
            ),
          )
        ),
      ],
    );
  }
}
