import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/coach_tutorial_parts.dart';
import 'package:kanpractice/infrastructure/preferences/preferences_repository_impl.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
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
          if (y == 1) align = ContentAlign.bottom;
          if (y == 0) offset = const Offset(0, KPMargins.margin64);
          break;
        case CoachTutorialParts.details:
          if (y != 0) align = ContentAlign.bottom;
          if (y == 0) offset = const Offset(0, KPMargins.margin64);
          break;
      }

      _targets.add(TargetFocus(
          identify: markers[y].currentWidget?.toString(),
          keyTarget: markers[y],
          shape: _part.shape[y],
          paddingFocus: KPMargins.margin8,
          contents: [
            TargetContent(
                align: align,
                child: Transform.translate(
                  offset: offset,
                  child: Container(
                    margin: part == CoachTutorialParts.details &&
                            y == markers.length - 1
                        ? const EdgeInsets.only(
                            top: KPMargins.margin64 + KPMargins.margin32)
                        : null,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_tutorialText[y],
                            style: const TextStyle(
                                fontSize: 12,
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
        colorShadow: KPColors.secondaryDarkerColor,
        focusAnimationDuration: const Duration(milliseconds: 200),
        opacityShadow: 0.9,
        hideSkip: true,
        pulseEnable: false,
        onFinish: () {
          switch (_part) {
            case CoachTutorialParts.kanList:
              getIt<PreferencesRepositoryImpl>()
                  .saveData(SharedKeys.haveSeenKanListCoachMark, true);
              break;
            case CoachTutorialParts.details:
              getIt<PreferencesRepositoryImpl>()
                  .saveData(SharedKeys.haveSeenKanListDetailCoachMark, true);
              break;
          }
          onEnd();
        },
      ).show(context: context);
    });
  }
}
