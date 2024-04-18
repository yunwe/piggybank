import 'package:flutter/material.dart';

class ColorManager {
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static Color primary = HexColor.fromHex("#a5fac3");
  static Color darkPrimary = HexColor.fromHex("#055959");
  static Color primaryOpacity70 = HexColor.fromHex("#b3a5fac3");
  static Color hotPink = HexColor.fromHex("#f514c4");
  static Color darkGrey = HexColor.fromHex("#5e9170");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color grey = HexColor.fromHex("#737477");
  static Color error = HexColor.fromHex("#e80505");
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
