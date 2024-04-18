import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/color_manager.dart';

import 'font_manager.dart';

class StyleManager {
  static TextStyle get appBarTitle {
    return const TextStyle(
      fontFamily: FontConstants.rokkitt,
      fontWeight: FontWeightManager.bold,
      fontSize: FontSize.title,
    );
  }

  static TextStyle get buttonText {
    return const TextStyle(
      fontFamily: FontConstants.rokkitt,
      fontWeight: FontWeightManager.bold,
      fontSize: FontSize.title,
    );
  }

  static TextStyle bodyText({
    Color color = ColorManager.black,
    double fontSize = FontSize.medium,
  }) {
    return TextStyle(
      fontFamily: FontConstants.figtree,
      fontSize: fontSize,
      color: color,
    );
  }

  static Gradient get backgroundGradient => LinearGradient(
        colors: [ColorManager.primary, ColorManager.darkPrimary],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
}
