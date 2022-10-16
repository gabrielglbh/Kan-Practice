import 'package:flutter/material.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/types/coach_tutorial_parts.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialCoach {
  final CoachTutorialParts _part;
  final List<GlobalKey> markers;
  final List<TargetFocus> _targets = [];
  List<String> _tutorialText = [];

  TutorialCoach(this.markers, this._part) {
    _tutorialText = _part.texts;
    _initTargets(markers, _part);
  }

  _initTargets(List<GlobalKey> markers, CoachTutorialParts part) {
    _targets.clear();
    for (int y = 0; y < markers.length; y++) {
      ContentAlign align = ContentAlign.top;
      Offset offset = const Offset(0, 0);
      switch (_part) {
        case CoachTutorialParts.kanList:
          if (y == 0) offset = const Offset(0, Margins.margin32);
          break;
        case CoachTutorialParts.details:
          if (y != 0) align = ContentAlign.bottom;
          if (y == 0) offset = const Offset(0, Margins.margin64);
          break;
      }

      _targets.add(TargetFocus(
          identify: markers[y].currentWidget?.toString(),
          keyTarget: markers[y],
          shape: _part.shape[y],
          paddingFocus: Margins.margin8,
          contents: [
            TargetContent(
                align: align,
                child: Transform.translate(
                  offset: offset,
                  child: Container(
                    margin: part == CoachTutorialParts.details &&
                            y == markers.length - 1
                        ? const EdgeInsets.only(
                            top: Margins.margin64 + Margins.margin32)
                        : null,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_tutorialText[y],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ))
          ]));
    }
  }

  Future<void> showTutorial(BuildContext context,
      {required Function() onEnd}) async {
    /// Added a few delay in order for the coach to load up properly
    await Future.delayed(const Duration(seconds: 1), () {
      TutorialCoachMark(
        targets: _targets,
        colorShadow: CustomColors.secondaryDarkerColor,
        focusAnimationDuration: const Duration(milliseconds: 200),
        opacityShadow: 0.9,
        hideSkip: true,
        pulseEnable: false,
        onFinish: () {
          switch (_part) {
            case CoachTutorialParts.kanList:
              StorageManager.saveData(
                  StorageManager.haveSeenKanListCoachMark, true);
              break;
            case CoachTutorialParts.details:
              StorageManager.saveData(
                  StorageManager.haveSeenKanListDetailCoachMark, true);
              break;
          }
          onEnd();
        },
      ).show(context: context);
    });
  }
}
