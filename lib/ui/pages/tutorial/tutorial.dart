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

class TutorialPage extends StatelessWidget {
  const TutorialPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      body: SafeArea(
        child: BulletPageView(
          bullets: 7,
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
      )
    );
  }

  Column _tutorialPage(BuildContext context, TutorialView view) {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.75,
                padding: EdgeInsets.all(8),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Image.asset(view.asset)
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Text(view.tutorial, style: TextStyle(color: Colors.white))
                  ),
                )
              ),
            ],
          ),
        ),
        Visibility(
          visible: view == TutorialView.tests,
          child: Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: ActionButton(
              label: "tutorial_done".tr(),
              color: Colors.white,
              textColor: Colors.black,
              onTap: () {
                StorageManager.saveData(StorageManager.hasDoneTutorial, true);
                Navigator.of(context).pushReplacementNamed(KanPracticePages.kanjiListPage);
              }
            ),
          )
        )
      ],
    );
  }
}
