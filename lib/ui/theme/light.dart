import 'package:flutter/material.dart';

import 'consts.dart';

final Color _primary = Colors.white;
final Color _cardColor = Colors.grey[200]!;
final Color _chipColor = Colors.grey[500]!;
final Color _accent = Colors.black;
final Color _subtle = Colors.grey[600]!;

final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: _primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: _accent,
        brightness: Brightness.light
    ),
    appBarTheme: AppBarTheme(
        color: _primary,
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: FontSizes.fontSize32, color: _accent),
        iconTheme: IconThemeData(color: _accent),
    ),
    iconTheme: IconThemeData(color: _accent),
    textTheme: TextTheme(
        headline1: TextStyle(color: _accent),
        headline2: TextStyle(color: _accent),
        headline3: TextStyle(color: _accent),
        headline4: TextStyle(color: _accent),
        headline5: TextStyle(color: _accent),
        headline6: TextStyle(color: _accent),
        subtitle1: TextStyle(color: _accent),
        subtitle2: TextStyle(color: _accent),
        bodyText1: TextStyle(color: _accent),
        bodyText2: TextStyle(color: _accent),
        caption: TextStyle(color: _subtle),
        button: TextStyle(color: _accent),
        overline: TextStyle(color: _accent)
    ),
    cardTheme: CardTheme(
        color: _cardColor,
        elevation: 8
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(CustomColors.secondaryColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(CustomRadius.radius8))),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius16))),
    ),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius16))),
        elevation: 6,
        contentTextStyle: TextStyle(color: _accent)
    ),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: CustomColors.secondaryColor
    ),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius24)),
          borderSide: BorderSide(color: _accent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius24)),
          borderSide: BorderSide(color: CustomColors.secondaryColor, width: 2.0),
        )
    ),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(CustomRadius.radius16),
                topRight: Radius.circular(CustomRadius.radius16)
            )
        )
    ),
    dialogBackgroundColor: _primary,
    chipTheme: ChipThemeData(
        selectedColor: CustomColors.secondaryColor,
        secondaryLabelStyle: TextStyle(color: _primary),
        brightness: Brightness.light,
        backgroundColor: _chipColor,
        padding: EdgeInsets.all(Margins.margin4),
        disabledColor: Colors.grey,
        labelStyle: TextStyle(color: _primary),
        secondarySelectedColor: _accent
    ),
    tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
        labelStyle: TextStyle(fontSize: FontSizes.fontSize18, fontWeight: FontWeight.bold),
        indicator: ShapeDecoration(
          shape: UnderlineInputBorder(
              borderSide: BorderSide(color: CustomColors.secondarySubtleColor,
                  width: 2, style: BorderStyle.solid)),
        )
    )
);