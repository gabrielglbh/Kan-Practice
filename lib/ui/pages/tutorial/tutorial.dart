import 'package:flutter/material.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/tutorial/widgets/BulletPageView.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/ActionButton.dart';
import 'package:easy_localization/easy_localization.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      body: Center(
        child: BulletPageView(
          bullets: 6,
          pageViewChildren: [
            _tutorialPage(context, 0, "tutorial_kanlist".tr(), "documentation/kanlist.png"),
            _tutorialPage(context, 1, "tutorial_lists".tr(), "documentation/lists.png"),
            _tutorialPage(context, 2, "tutorial_details".tr(), "documentation/details.png"),
            _tutorialPage(context, 3, "tutorial_writing".tr(), "documentation/writing.png"),
            _tutorialPage(context, 4, "tutorial_reading".tr(), "documentation/reading.png"),
            _tutorialPage(context, 5, "tutorial_recognition".tr(), "documentation/recognition.png"),
          ],
          height: 1.11,
        ),
      )
    );
  }

  Column _tutorialPage(BuildContext context, int index, String tutorial, String asset) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 16,
                height: MediaQuery.of(context).size.height / 2.5,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: 72),
                alignment: Alignment.center,
                child: Image.asset(asset),
              ),
              Padding(
                padding: EdgeInsets.only(right: 64, left: 64, bottom: 4),
                child: Divider(),
              ),
              Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Text(tutorial, textAlign: TextAlign.justify)
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
        Visibility(
          visible: index == 5,
          child: Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: ActionButton(
              label: "Done",
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
