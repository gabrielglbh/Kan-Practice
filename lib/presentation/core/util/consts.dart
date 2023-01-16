import 'package:flutter/material.dart';

class KPSizes {
  static const double defaultSizeDragContainerHeight = 5;
  static const double defaultSizeLearningExtContainer = 20;
  static const double defaultSizeLearningModeBar = 32;
  static const double defaultResultWordListOnTest = 40;
  static const double defaultSizeFiltersList = 44;
  static const double defaultSizeSearchBarIcons = 50;
  static const double defaultJishoAPIContainer = 52;
  static const double defaultSizeActionButton = 60;
  static const double defaultSizeWordItemOnResultTest = 60;
  static const double actionButtonsWordDetail = 55;
  static const double appBarHeight = 80;
  static const double listStudyHeight = 85;
  static const double defaultSizeDragContainerWidth = 90;
  static const double customButtonHeight = 100;
  static const double defaultSizeWinRateBarChart = 110;
  static const double customButtonWidth = 110;
  static const double defaultJishoGIF = 124;
  static const double defaultSizeWinRateChart = 128;
  static const double appIcon = 150;
  static const double maxHeightForLastSeenDates = 256;
  static const double maxHeightValidationCircle = 256;

  static const double minimumHeight = 750;

  static const int numberOfWordInTest = 30;
  static const int numberOfPredictedWords = 20;
}

class LazyLoadingLimits {
  static const int folderList = 12;
  static const int kanList = 12;
  static const int wordList = 100;
  static const int grammarPointList = 20;
  static const int testHistory = 20;
  static const int wordHistory = 20;
}

class KPChartSize {
  static const double small = 8;
  static const double medium = 12;
  static const double large = 32;
}

class KPMargins {
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

class KPFontSizes {
  static const double fontSize12 = 12;
  static const double fontSize14 = 14;
  static const double fontSize16 = 16;
  static const double fontSize18 = 18;
  static const double fontSize20 = 20;
  static const double fontSize24 = 24;
  static const double fontSize26 = 26;
  static const double fontSize32 = 32;
  static const double fontSize48 = 48;
  static const double fontSize64 = 64;
}

class KPRadius {
  static const double radius4 = 4;
  static const double radius8 = 8;
  static const double radius16 = 16;
  static const double radius24 = 24;
  static const double radius32 = 32;
}

class KPAnimations {
  static const double dxCardInfo = 2;

  static const int wordItemDuration = 25;
  static const int ms200 = 200;
  static const int ms300 = 300;
  static const int ms400 = 400;
}

class KPColors {
  static Color getSecondaryColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? secondaryDarkerColor
          : secondaryColor;

  static Color getPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? primaryLight
          : primaryDark;

  static Color getCardColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? cardColorLight
          : cardColorDark;

  static Color getAccent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? accentLight
          : accentDark;

  static Color getAlterAccent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? accentDark
          : accentLight;

  static Color getSubtle(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? subtleLight
          : subtleDark;

  static const Color secondaryDarkerColor = Color(0xFFD32F2F);
  static const Color secondaryColor = Color(0xFFE57373);

  static const Color primaryLight = Colors.white;
  static final Color primaryDark = Colors.grey.shade700;
  static final Color cardColorLight = Colors.grey.shade200;
  static final Color cardColorDark = Colors.grey.shade600;
  static final Color midGrey = Colors.grey.shade500;
  static const Color accentLight = Colors.black;
  static const Color accentDark = Colors.white;
  static final Color subtleLight = Colors.grey.shade600;
  static final Color subtleDark = Colors.grey.shade400;
}
