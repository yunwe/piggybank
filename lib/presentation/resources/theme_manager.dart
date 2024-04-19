import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/color_manager.dart';
import 'package:piggybank/presentation/resources/font_manager.dart';
import 'package:piggybank/presentation/resources/style_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey,
    // ripple color
    splashColor: ColorManager.primaryOpacity70,

    // card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: 4,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.white,
      elevation: 4,
      shadowColor: ColorManager.primaryOpacity70,
      titleTextStyle: StyleManager.appBarTitle,
    ),
    // Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.darkPrimary,
        textStyle: StyleManager.buttonText,
      ),
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: StyleManager.buttonText,
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.darkGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    //Text theme
    textTheme: TextTheme(
      headlineLarge: StyleManager.headlineText(
        fontSize: FontSize.extraLarge,
        color: ColorManager.darkPrimary,
      ),
      bodySmall: StyleManager.bodyText(fontSize: FontSize.small),
      bodyMedium: StyleManager.bodyText(fontSize: FontSize.medium),
      bodyLarge: StyleManager.bodyText(fontSize: FontSize.large),
    ),
  );
}
