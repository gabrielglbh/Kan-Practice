import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

const Color _primary = Colors.white;
final Color _cardColor = Colors.grey.shade200;
final Color _chipColor = Colors.grey.shade500;
const Color _accent = Colors.black;
final Color _subtle = Colors.grey.shade600;

final ThemeData light = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: _primary,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: _accent, brightness: Brightness.light),
  appBarTheme: const AppBarTheme(
    color: _primary,
    elevation: 0,
    titleTextStyle: TextStyle(fontSize: KPFontSizes.fontSize32, color: _accent),
    iconTheme: IconThemeData(color: _accent),
  ),
  iconTheme: const IconThemeData(color: _accent),
  textTheme: TextTheme(
      headline1: const TextStyle(color: _accent),
      headline2: const TextStyle(color: _accent),
      headline3:
          const TextStyle(color: _accent, fontSize: KPFontSizes.fontSize64),
      headline4:
          const TextStyle(color: _accent, fontSize: KPFontSizes.fontSize32),
      headline5: const TextStyle(
          color: _accent,
          fontSize: KPFontSizes.fontSize24,
          fontWeight: FontWeight.bold),
      headline6: const TextStyle(
          color: _accent,
          fontSize: KPFontSizes.fontSize18,
          fontWeight: FontWeight.bold),
      subtitle1: const TextStyle(color: _accent),
      subtitle2: const TextStyle(
          color: _accent,
          fontSize: KPFontSizes.fontSize12,
          fontWeight: FontWeight.w400),
      bodyText1: const TextStyle(
          color: _accent,
          fontSize: KPFontSizes.fontSize16,
          fontWeight: FontWeight.w400),
      bodyText2:
          const TextStyle(color: _accent, fontSize: KPFontSizes.fontSize14),
      caption: TextStyle(color: _subtle),
      button: const TextStyle(
          color: _primary,
          fontSize: KPFontSizes.fontSize16,
          fontWeight: FontWeight.bold),
      overline: const TextStyle(
          color: KPColors.secondaryDarkerColor,
          decoration: TextDecoration.underline,
          fontSize: KPFontSizes.fontSize14)),
  cardTheme: CardTheme(color: _cardColor, elevation: 8),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(KPColors.secondaryDarkerColor),
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KPRadius.radius8))),
    ),
  ),
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(KPRadius.radius16))),
  ),
  snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(KPRadius.radius16))),
      elevation: 12,
      contentTextStyle: TextStyle(color: _primary)),
  textSelectionTheme:
      const TextSelectionThemeData(cursorColor: KPColors.secondaryDarkerColor),
  inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey[400]),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(KPRadius.radius24)),
        borderSide: BorderSide(color: _accent),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(KPRadius.radius24)),
        borderSide:
            BorderSide(color: KPColors.secondaryDarkerColor, width: 2.0),
      )),
  bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: _primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(KPRadius.radius16),
              topRight: Radius.circular(KPRadius.radius16)))),
  dialogBackgroundColor: _primary,
  chipTheme: ChipThemeData(
      selectedColor: KPColors.secondaryDarkerColor,
      secondaryLabelStyle: const TextStyle(color: _primary),
      brightness: Brightness.light,
      backgroundColor: _chipColor,
      padding: const EdgeInsets.all(KPMargins.margin4),
      disabledColor: Colors.grey,
      labelStyle: const TextStyle(color: _primary),
      secondarySelectedColor: _accent),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.black,
    labelStyle: TextStyle(
        fontSize: KPFontSizes.fontSize18, fontWeight: FontWeight.bold),
    indicator: ShapeDecoration(
      shape: UnderlineInputBorder(
          borderSide: BorderSide(
              color: KPColors.secondaryDarkerColor,
              width: 2,
              style: BorderStyle.solid)),
    ),
  ),
  radioTheme: RadioThemeData(
      fillColor:
          MaterialStateProperty.all<Color>(KPColors.secondaryDarkerColor)),
);
