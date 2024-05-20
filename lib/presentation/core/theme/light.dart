import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

final _colorScheme = ColorScheme.fromSeed(seedColor: KPColors.secondaryColor);

final ThemeData light = ThemeData(
  useMaterial3: true,
  colorScheme: _colorScheme,
  textTheme: TextTheme(
    displayLarge: TextStyle(
        color: _colorScheme.onSurface, fontSize: KPFontSizes.fontSize64),
    displaySmall: TextStyle(
        color: _colorScheme.onSurface, fontSize: KPFontSizes.fontSize48),
    headlineMedium: TextStyle(
        color: _colorScheme.onSurface, fontSize: KPFontSizes.fontSize32),
    headlineSmall: TextStyle(
        color: _colorScheme.onSurface,
        fontSize: KPFontSizes.fontSize24,
        fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
        color: _colorScheme.onSurface,
        fontSize: KPFontSizes.fontSize18,
        fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: _colorScheme.onSurface),
    titleSmall: TextStyle(
        color: _colorScheme.onSurface,
        fontSize: KPFontSizes.fontSize12,
        fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(
        color: _colorScheme.onSurface,
        fontSize: KPFontSizes.fontSize16,
        fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(
        color: _colorScheme.onSurface, fontSize: KPFontSizes.fontSize14),
    bodySmall: TextStyle(color: KPColors.subtleLight),
    labelLarge: TextStyle(
        color: _colorScheme.onSurface,
        fontSize: KPFontSizes.fontSize16,
        fontWeight: FontWeight.bold),
    labelSmall: const TextStyle(
        color: KPColors.secondaryDarkerColor,
        decoration: TextDecoration.underline,
        fontSize: KPFontSizes.fontSize14),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    titleTextStyle: TextStyle(
        fontSize: KPFontSizes.fontSize32, color: _colorScheme.onSurface),
  ),
  sliderTheme: const SliderThemeData(trackHeight: 8),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(_colorScheme.primary),
      shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
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
  ),
  inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius:
            const BorderRadius.all(Radius.circular(KPRadius.radius24)),
        borderSide: BorderSide(color: _colorScheme.primaryFixed),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            const BorderRadius.all(Radius.circular(KPRadius.radius24)),
        borderSide: BorderSide(color: _colorScheme.primaryFixed, width: 2.0),
      )),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(KPRadius.radius16),
            topRight: Radius.circular(KPRadius.radius16))),
  ),
  chipTheme: const ChipThemeData(padding: EdgeInsets.all(KPMargins.margin4)),
  tabBarTheme: TabBarTheme(
    dividerColor: _colorScheme.surface,
    indicatorSize: TabBarIndicatorSize.tab,
    labelStyle: const TextStyle(
        fontSize: KPFontSizes.fontSize18, fontWeight: FontWeight.bold),
  ),
);
