import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

final ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: KPColors.primaryDark,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: KPColors.accentDark, brightness: Brightness.dark),
  appBarTheme: AppBarTheme(
    color: KPColors.primaryDark,
    elevation: 0,
    titleTextStyle: const TextStyle(
        fontSize: KPFontSizes.fontSize32, color: KPColors.accentDark),
    iconTheme: const IconThemeData(color: KPColors.accentDark),
  ),
  iconTheme: const IconThemeData(color: KPColors.accentDark),
  textTheme: TextTheme(
      displayLarge: const TextStyle(
          color: KPColors.accentDark, fontSize: KPFontSizes.fontSize64),
      displaySmall: const TextStyle(
          color: KPColors.accentDark, fontSize: KPFontSizes.fontSize48),
      headlineMedium: const TextStyle(
          color: KPColors.accentDark, fontSize: KPFontSizes.fontSize32),
      headlineSmall: const TextStyle(
          color: KPColors.accentDark,
          fontSize: KPFontSizes.fontSize24,
          fontWeight: FontWeight.bold),
      titleLarge: const TextStyle(
          color: KPColors.accentDark,
          fontSize: KPFontSizes.fontSize18,
          fontWeight: FontWeight.bold),
      titleMedium: const TextStyle(color: KPColors.accentDark),
      titleSmall: const TextStyle(
          color: KPColors.accentDark,
          fontSize: KPFontSizes.fontSize12,
          fontWeight: FontWeight.w400),
      bodyLarge: const TextStyle(
          color: KPColors.accentDark,
          fontSize: KPFontSizes.fontSize16,
          fontWeight: FontWeight.w400),
      bodyMedium: const TextStyle(
          color: KPColors.accentDark, fontSize: KPFontSizes.fontSize14),
      bodySmall: TextStyle(color: KPColors.subtleDark),
      labelLarge: const TextStyle(
          color: KPColors.accentDark,
          fontSize: KPFontSizes.fontSize16,
          fontWeight: FontWeight.bold),
      labelSmall: const TextStyle(
          color: KPColors.secondaryDarkerColor,
          decoration: TextDecoration.underline,
          fontSize: KPFontSizes.fontSize14)),
  cardTheme: CardTheme(color: KPColors.cardColorDark, elevation: 8),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: KPColors.secondaryDarkerColor,
    selectionColor: KPColors.secondaryColor,
    selectionHandleColor: KPColors.secondaryColor,
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 8,
    thumbColor: KPColors.secondaryDarkerColor,
    activeTrackColor: KPColors.secondaryColor,
    inactiveTrackColor: KPColors.cardColorLight,
    overlayColor: KPColors.secondaryDarkerColor.withOpacity(.4),
  ),
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
      contentTextStyle: TextStyle(color: KPColors.accentDark)),
  inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey[400]),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            const BorderRadius.all(Radius.circular(KPRadius.radius24)),
        borderSide: BorderSide(color: KPColors.subtleDark),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(KPRadius.radius24)),
        borderSide: BorderSide(color: KPColors.secondaryColor, width: 2.0),
      )),
  bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: KPColors.primaryDark,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(KPRadius.radius24),
              topRight: Radius.circular(KPRadius.radius24)))),
  dialogBackgroundColor: KPColors.primaryDark,
  chipTheme: ChipThemeData(
      selectedColor: KPColors.secondaryColor,
      secondaryLabelStyle: const TextStyle(color: KPColors.accentLight),
      brightness: Brightness.dark,
      backgroundColor: KPColors.midGrey,
      padding: const EdgeInsets.all(KPMargins.margin4),
      disabledColor: Colors.grey,
      labelStyle: const TextStyle(color: KPColors.accentDark),
      secondarySelectedColor: KPColors.accentDark),
  tabBarTheme: const TabBarTheme(
    labelColor: KPColors.accentDark,
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
