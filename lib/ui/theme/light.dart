import 'package:flutter/material.dart';

import '../consts.dart';

const Color _primary = Colors.white;
final Color _cardColor = Colors.grey.shade200;
final Color _chipColor = Colors.grey.shade500;
const Color _accent = Colors.black;
final Color _subtle = Colors.grey.shade600;
final Color _nav = Colors.grey.shade700;

final ThemeData light = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: _primary,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: _accent, brightness: Brightness.light),
  appBarTheme: const AppBarTheme(
    color: _primary,
    elevation: 0,
    titleTextStyle: TextStyle(fontSize: FontSizes.fontSize32, color: _accent),
    iconTheme: IconThemeData(color: _accent),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _primary,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: CustomColors.secondaryDarkerColor,
      selectedIconTheme:
          const IconThemeData(color: CustomColors.secondaryDarkerColor),
      unselectedIconTheme: IconThemeData(color: _nav),
      unselectedLabelStyle: TextStyle(color: _nav)),
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
          color: _primary,
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
          MaterialStateProperty.all<Color>(CustomColors.secondaryDarkerColor),
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CustomRadius.radius8))),
    ),
  ),
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius16))),
  ),
  snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(CustomRadius.radius16))),
      elevation: 12,
      contentTextStyle: TextStyle(color: _primary)),
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: CustomColors.secondaryDarkerColor),
  inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey[400]),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius24)),
        borderSide: BorderSide(color: _accent),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius24)),
        borderSide:
            BorderSide(color: CustomColors.secondaryDarkerColor, width: 2.0),
      )),
  bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: _primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(CustomRadius.radius16),
              topRight: Radius.circular(CustomRadius.radius16)))),
  dialogBackgroundColor: _primary,
  chipTheme: ChipThemeData(
      selectedColor: CustomColors.secondaryDarkerColor,
      secondaryLabelStyle: const TextStyle(color: _primary),
      brightness: Brightness.light,
      backgroundColor: _chipColor,
      padding: const EdgeInsets.all(Margins.margin4),
      disabledColor: Colors.grey,
      labelStyle: const TextStyle(color: _primary),
      secondarySelectedColor: _accent),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.black,
    labelStyle:
        TextStyle(fontSize: FontSizes.fontSize18, fontWeight: FontWeight.bold),
    indicator: ShapeDecoration(
      shape: UnderlineInputBorder(
          borderSide: BorderSide(
              color: CustomColors.secondaryDarkerColor,
              width: 2,
              style: BorderStyle.solid)),
    ),
  ),
  radioTheme: RadioThemeData(
      fillColor:
          MaterialStateProperty.all<Color>(CustomColors.secondaryDarkerColor)),
);
