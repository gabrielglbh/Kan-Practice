import 'package:flutter/material.dart';

const double defaultSizeSearchBarIcons = 50;
const double appBarHeight = 80;
const double customButtonHeight = 90;
const double studyModeWidgetHeight = 180;
const double alertDialogHeight = 100;
const double listStudyHeight = 85;
const double studyGuideHeight = listStudyHeight + 44;
const double customButtonWidth = 110;
const double bottomSheetHeight = 360;

const int numberOfKanjiInTest = 30;

const Color secondaryColor = Color(0xFFD32F2F);
const Color secondarySubtleColor = Color(0xFFE57373);

final ButtonStyle correctButton = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
);

final ButtonStyle wrongButton = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
  shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
);