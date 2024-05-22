import 'package:flutter/material.dart';

class MyColors {
  static Color primary = HexColor.fromHex("#388da9");
  static Color lightGrey = HexColor.fromHex("#878787");
  static Color offWhite = HexColor.fromHex('#d287e8');
  static Color backgroundGradient = HexColor.fromHex('#33FFA726');
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
