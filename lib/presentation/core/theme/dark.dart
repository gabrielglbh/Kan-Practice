import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

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
        const TextStyle(fontSize: KPFontSizes.fontSize32, color: _accent),
    iconTheme: const IconThemeData(color: _accent),
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
          color: _accent,
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
          MaterialStateProperty.all<Color>(KPColors.secondaryColor),
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KPRadius.radius8))),
    ),
  ),
  dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(KPRadius.radius16)))),
  snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(KPRadius.radius16))),
      elevation: 12,
      contentTextStyle: TextStyle(color: _accent)),
  textSelectionTheme:
      const TextSelectionThemeData(cursorColor: KPColors.secondaryColor),
  inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey[400]),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(KPRadius.radius24)),
        borderSide: BorderSide(color: _accent),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(KPRadius.radius24)),
        borderSide: BorderSide(color: KPColors.secondaryColor, width: 2.0),
      )),
  bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: _primary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(KPRadius.radius24),
              topRight: Radius.circular(KPRadius.radius24)))),
  dialogBackgroundColor: _primary,
  chipTheme: ChipThemeData(
      selectedColor: KPColors.secondaryColor,
      secondaryLabelStyle: const TextStyle(color: Colors.black),
      brightness: Brightness.dark,
      backgroundColor: _chipColor,
      padding: const EdgeInsets.all(KPMargins.margin4),
      disabledColor: Colors.grey,
      labelStyle: const TextStyle(color: _accent),
      secondarySelectedColor: _accent),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.white,
    labelStyle: TextStyle(
        fontSize: KPFontSizes.fontSize18, fontWeight: FontWeight.bold),
    indicator: ShapeDecoration(
      shape: UnderlineInputBorder(
          borderSide: BorderSide(
              color: KPColors.secondaryColor,
              width: 2,
              style: BorderStyle.solid)),
    ),
  ),
  radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all<Color>(KPColors.secondaryColor)),
);
