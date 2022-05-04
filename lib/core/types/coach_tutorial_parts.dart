import 'package:easy_localization/easy_localization.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

enum CoachTutorialParts {
  kanList, details
}

extension CoachTutorialPartsExt on CoachTutorialParts {
  List<String> get texts {
    switch(this) {
      case CoachTutorialParts.kanList:
        return [
          "coach_tutorial_kanlists_1".tr(),
          "coach_tutorial_kanlists_2".tr(),
          "coach_tutorial_kanlists_3".tr()
        ];
      case CoachTutorialParts.details:
        return [
          "coach_tutorial_detail_1".tr(),
          "coach_tutorial_detail_2".tr(),
          "coach_tutorial_detail_3".tr(),
          "coach_tutorial_detail_4".tr()
        ];
    }
  }

  List<ShapeLightFocus> get shape {
    switch(this) {
      case CoachTutorialParts.kanList:
        return [
          ShapeLightFocus.RRect,
          ShapeLightFocus.RRect,
          ShapeLightFocus.Circle
        ];
      case CoachTutorialParts.details:
        return [
          ShapeLightFocus.RRect,
          ShapeLightFocus.Circle,
          ShapeLightFocus.Circle,
          ShapeLightFocus.Circle
        ];
    }
  }
}