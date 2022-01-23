import 'package:flutter/material.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:easy_localization/easy_localization.dart';

enum CoachTutorialParts { kanList, details }

class TutorialCoach {
  CoachTutorialParts _part;
  List<GlobalKey> _markers = [];
  List<TargetFocus> _targets = [];
  List<String> _tutorialText = [];

  TutorialCoach(this._markers, this._part) {
    if (_part == CoachTutorialParts.kanList) {
      _tutorialText = [
        "coach_tutorial_kanlists_1".tr(),
        "coach_tutorial_kanlists_2".tr(),
        "coach_tutorial_kanlists_3".tr()
      ];
    } else {
      _tutorialText = [
        "coach_tutorial_detail_1".tr(),
        "coach_tutorial_detail_2".tr(),
        "coach_tutorial_detail_3".tr(),
        "coach_tutorial_detail_4".tr()
      ];
    }
    _initTargets(_markers, _part);
  }

  _initTargets(List<GlobalKey> markers, CoachTutorialParts part) {
    _targets.clear();
    for (int y = 0; y < markers.length; y++) {
      ContentAlign align = ContentAlign.top;
      if (part == CoachTutorialParts.kanList) {
        if (y == markers.length - 1) align = ContentAlign.bottom;
      } else {
        if (y != 0) align = ContentAlign.bottom;
      }

      _targets.add(TargetFocus(
        identify: markers[y].currentWidget?.toString(),
        keyTarget: markers[y],
        contents: [
          TargetContent(
            align: align,
            child: Container(
              margin: part == CoachTutorialParts.details && y == markers.length - 1
                  ? EdgeInsets.only(top: Margins.margin64 + Margins.margin32) : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_tutorialText[y], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          )
        ]
      ));
    }
  }

  showTutorial(BuildContext context, {required Function() onEnd}) {
    TutorialCoachMark(
      context,
      targets: _targets,
      colorShadow: CustomColors.secondaryDarkerColor,
      opacityShadow: 0.9,
      hideSkip: true,
      onFinish: () {
        if (_part == CoachTutorialParts.kanList)
          StorageManager.saveData(StorageManager.haveSeenKanListCoachMark, true);
        else if (_part == CoachTutorialParts.details)
          StorageManager.saveData(StorageManager.haveSeenKanListDetailCoachMark, true);
        onEnd();
      },
    )..show();
  }
}