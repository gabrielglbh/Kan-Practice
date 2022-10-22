import 'package:flutter/material.dart';

import '../../../../ui/consts.dart';

final Color _primary = Colors.grey.shade700;
final Color _cardColor = Colors.grey.shade600;
final Color _chipColor = Colors.grey.shade500;
const Color _accent = Colors.white;
final Color _subtle = Colors.grey.shade400;

final ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: _primary,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: _accent, brightness: Brightness.dark),
  appBarTheme: AppBarTheme(
    color: _primary,
    elevation: 0,
    titleTextStyle:
        const TextStyle(fontSize: FontSizes.fontSize32, color: _accent),
    iconTheme: const IconThemeData(color: _accent),
  ),
  iconTheme: const IconThemeData(color: _accent),
  textTheme: TextTheme(
      headline1: const TextStyle(color: _accent),
      headline2: const TextStyle(color: _accent),
      headline3:
          const TextStyle(color: _accent, fontSize: FontSizes.fontSize64),
      headline4:
          const TextStyle(color: _accent, fontSize: FontSizes.fontSize32),
      headline5: const TextStyle(
          color: _accent,
          fontSize: FontSizes.fontSize24,
          fontWeight: FontWeight.bold),
      headline6: const TextStyle(
          color: _accent,
          fontSize: FontSizes.fontSize18,
          fontWeight: FontWeight.bold),
      subtitle1: const TextStyle(color: _accent),
      subtitle2: const TextStyle(
          color: _accent,
          fontSize: FontSizes.fontSize12,
          fontWeight: FontWeight.w400),
      bodyText1: const TextStyle(
          color: _accent,
          fontSize: FontSizes.fontSize16,
          fontWeight: FontWeight.w400),
      bodyText2:
          const TextStyle(color: _accent, fontSize: FontSizes.fontSize14),
      caption: TextStyle(color: _subtle),
      button: const TextStyle(
          color: _accent,
          fontSize: FontSizes.fontSize16,
          fontWeight: FontWeight.bold),
      overline: const TextStyle(
          color: CustomColors.secondaryDarkerColor,
          decoration: TextDecoration.underline,
          fontSize: FontSizes.fontSize14)),
  cardTheme: CardTheme(color: _cardColor, elevation: 8),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(CustomColors.secondaryColor),
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CustomRadius.radius8))),
    ),
  ),
  dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(CustomRadius.radius16)))),
  snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(CustomRadius.radius16))),
      elevation: 12,
      contentTextStyle: TextStyle(color: _accent)),
  textSelectionTheme:
      const TextSelectionThemeData(cursorColor: CustomColors.secondaryColor),
  inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey[400]),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius24)),
        borderSide: BorderSide(color: _accent),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius24)),
        borderSide: BorderSide(color: CustomColors.secondaryColor, width: 2.0),
      )),
  bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: _primary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(CustomRadius.radius24),
              topRight: Radius.circular(CustomRadius.radius24)))),
  dialogBackgroundColor: _primary,
  chipTheme: ChipThemeData(
      selectedColor: CustomColors.secondaryColor,
      secondaryLabelStyle: const TextStyle(color: Colors.black),
      brightness: Brightness.dark,
      backgroundColor: _chipColor,
      padding: const EdgeInsets.all(Margins.margin4),
      disabledColor: Colors.grey,
      labelStyle: const TextStyle(color: _accent),
      secondarySelectedColor: _accent),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.white,
    labelStyle:
        TextStyle(fontSize: FontSizes.fontSize18, fontWeight: FontWeight.bold),
    indicator: ShapeDecoration(
      shape: UnderlineInputBorder(
          borderSide: BorderSide(
              color: CustomColors.secondaryColor,
              width: 2,
              style: BorderStyle.solid)),
    ),
  ),
  radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all<Color>(CustomColors.secondaryColor)),
);
