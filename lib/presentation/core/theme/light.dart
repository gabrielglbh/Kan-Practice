import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

final ThemeData light = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: KPColors.primaryLight,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: KPColors.accentLight, brightness: Brightness.light),
  appBarTheme: const AppBarTheme(
    color: KPColors.primaryLight,
    elevation: 0,
    titleTextStyle: TextStyle(
        fontSize: KPFontSizes.fontSize32, color: KPColors.accentLight),
    iconTheme: IconThemeData(color: KPColors.accentLight),
  ),
  iconTheme: const IconThemeData(color: KPColors.accentLight),
  textTheme: TextTheme(
      displayLarge: const TextStyle(color: KPColors.accentLight),
      displaySmall: const TextStyle(
          color: KPColors.accentLight, fontSize: KPFontSizes.fontSize64),
      headlineMedium: const TextStyle(
          color: KPColors.accentLight, fontSize: KPFontSizes.fontSize32),
      headlineSmall: const TextStyle(
          color: KPColors.accentLight,
          fontSize: KPFontSizes.fontSize24,
          fontWeight: FontWeight.bold),
      titleLarge: const TextStyle(
          color: KPColors.accentLight,
          fontSize: KPFontSizes.fontSize18,
          fontWeight: FontWeight.bold),
      titleMedium: const TextStyle(color: KPColors.accentLight),
      titleSmall: const TextStyle(
          color: KPColors.accentLight,
          fontSize: KPFontSizes.fontSize12,
          fontWeight: FontWeight.w400),
      bodyLarge: const TextStyle(
          color: KPColors.accentLight,
          fontSize: KPFontSizes.fontSize16,
          fontWeight: FontWeight.w400),
      bodyMedium: const TextStyle(
          color: KPColors.accentLight, fontSize: KPFontSizes.fontSize14),
      bodySmall: TextStyle(color: KPColors.subtleLight),
      labelLarge: const TextStyle(
          color: KPColors.primaryLight,
          fontSize: KPFontSizes.fontSize16,
          fontWeight: FontWeight.bold),
      labelSmall: const TextStyle(
          color: KPColors.secondaryDarkerColor,
          decoration: TextDecoration.underline,
          fontSize: KPFontSizes.fontSize14)),
  cardTheme: CardTheme(color: KPColors.cardColorLight, elevation: 8),
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
      contentTextStyle: TextStyle(color: KPColors.primaryLight)),
  textSelectionTheme:
      const TextSelectionThemeData(cursorColor: KPColors.secondaryDarkerColor),
  inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey[400]),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            const BorderRadius.all(Radius.circular(KPRadius.radius24)),
        borderSide: BorderSide(color: KPColors.subtleLight),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(KPRadius.radius24)),
        borderSide:
            BorderSide(color: KPColors.secondaryDarkerColor, width: 2.0),
      )),
  bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: KPColors.primaryLight,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(KPRadius.radius16),
              topRight: Radius.circular(KPRadius.radius16)))),
  dialogBackgroundColor: KPColors.primaryLight,
  chipTheme: ChipThemeData(
      selectedColor: KPColors.secondaryDarkerColor,
      secondaryLabelStyle: const TextStyle(color: KPColors.primaryLight),
      brightness: Brightness.light,
      backgroundColor: KPColors.midGrey,
      padding: const EdgeInsets.all(KPMargins.margin4),
      disabledColor: Colors.grey,
      labelStyle: const TextStyle(color: KPColors.primaryLight),
      secondarySelectedColor: KPColors.accentLight),
  tabBarTheme: const TabBarTheme(
    labelColor: KPColors.accentLight,
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
