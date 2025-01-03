import 'package:flutter/material.dart';

import '../styles/app_styles.dart';
import '../styles/colors_app.dart';
import '../styles/text_styles.dart';

class ThemeConfig {
  ThemeConfig._();

  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: Colors.grey.shade400),
  );

  static final theme = ThemeData(
    fontFamily: 'mplus1',
    scaffoldBackgroundColor: ColorsApp.i.secondary,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsApp.i.primary,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: TextStyles.i.textBold,
    ),
    primaryColor: ColorsApp.i.primary,
    colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsApp.i.primary,
        primary: ColorsApp.i.primary,
        secondary: ColorsApp.i.secondary),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: AppStyles.i.primaryButton),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.all(13),
      labelStyle: TextStyles.i.textRegular.copyWith(color: Colors.black87),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      errorStyle: TextStyles.i.textRegular.copyWith(color: Colors.redAccent),
    ),
    cardTheme: CardTheme(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
