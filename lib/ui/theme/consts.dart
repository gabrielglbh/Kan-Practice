import 'package:flutter/material.dart';

class CustomSizes {
  static const double defaultSizeDragContainerHeight = 5;
  static const double defaultSizeLearningExtContainer = 20;
  static const double defaultSizeLearningModeBar = 32;
  static const double defaultResultKanjiListOnTest = 40;
  static const double defaultSizeSearchBarIcons = 50;
  static const double largeSizeLearningExtContainer = 50;
  static const double defaultJishoAPIContainer = 52;
  static const double defaultSizeFiltersList = 60;
  static const double defaultSizeActionButton = 60;
  static const double defaultSizeKanjiItemOnResultTest = 60;
  static const double actionButtonsKanjiDetail = 65;
  static const double appBarHeight = 80;
  static const double defaultSizeWinRateChart = 80;
  static const double extraPaddingForFAB = 82;
  static const double listStudyHeight = 85;
  static const double defaultSizeDragContainerWidth = 90;
  static const double defaultSizeButtonHeight = 90;
  static const double defaultSizeRangesHeight = 90;
  static const double defaultSizeWinRateBarChart = 90;
  static const double alertDialogHeight = 100;
  static const double customButtonWidth = 110;
  static const double defaultJishoGIF = 124;
  static const double studyGuideHeight = listStudyHeight + 44;
  static const double appIcon = 150;
  static const double defaultSizeStudyModeSelection = 165;
  static const double maxHeightForListsTest = 240;
  static const double maxHeightValidationCircle = 256;

  static const double minimumHeight = 700;

  static const int numberOfKanjiInTest = 30;
  static const int numberOfPredictedKanji = 20;
}

class ChartSize {
  static const double small = 10;
  static const double medium = 32;
}

class Margins {
  static const double margin2 = 2;
  static const double margin4 = 4;
  static const double margin8 = 8;
  static const double margin10 = 10;
  static const double margin12 = 12;
  static const double margin16 = 16;
  static const double margin18 = 18;
  static const double margin24 = 24;
  static const double margin26 = 26;
  static const double margin32 = 32;
  static const double margin48 = 48;
  static const double margin64 = 64;
}

class FontSizes {
  static const double fontSize12 = 12;
  static const double fontSize14 = 14;
  static const double fontSize16 = 16;
  static const double fontSize18 = 18;
  static const double fontSize20 = 20;
  static const double fontSize24 = 24;
  static const double fontSize26 = 26;
  static const double fontSize32 = 32;
  static const double fontSize64 = 64;
}

class CustomRadius {
  static const double radius4 = 4;
  static const double radius8 = 8;
  static const double radius16 = 16;
  static const double radius24 = 24;
  static const double radius32 = 32;
}

class CustomAnimations {
  static const double dxCardInfo = 2;

  static const int kanjiItemDuration = 25;
  static const int ms200 = 200;
  static const int ms300 = 300;
  static const int ms400 = 400;
}

class CustomColors {
  static Color getSecondaryColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? secondaryDarkerColor : secondaryColor;

  static const Color secondaryDarkerColor = Color(0xFFD32F2F);
  static const Color secondaryColor = Color(0xFFE57373);
}