import 'package:flutter/material.dart';

class MyColors {
  static Color primary = HexColor.fromHex('#D0BFFF');
  static Color primaryL1 = HexColor.fromHex('#DFCCFB');
  static Color primaryD1 = HexColor.fromHex('#BEADFA');
  static Color primaryInverse = HexColor.fromHex('#FFF3DA');

  static Color khaki = HexColor.fromHex('#FFFBF5');
  static Color khakiD1 = HexColor.fromHex('#F7EFE5');
  static Color khakiPrimary = HexColor.fromHex('#C3ACD0');

  static Color onPrimary = HexColor.fromHex("#433e5e");
  static Color onWhite = HexColor.fromHex("#9591ae");

  static Color hotPink = HexColor.fromHex("#DA0C81");
  static Color darkBlue = HexColor.fromHex('#102C57');

  static Color textColor = Colors.black54;

  static ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: primary);
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
