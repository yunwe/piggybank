import 'package:flutter/material.dart';

class MyColors {
  static Color primary = HexColor.fromHex("#CEC6FF");
  static Color onPrimary = HexColor.fromHex("#433e5e");
  static Color hotPink = HexColor.fromHex("#FF084A");
  static Color darkGrey = HexColor.fromHex("#5e9170");

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
