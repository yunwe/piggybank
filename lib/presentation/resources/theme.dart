import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/resources.dart';

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
    MaterialState.disabled,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.grey;
  }
  return Colors.white;
}

ThemeData getApplicationTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: MyColors.primary,
    ),
    dividerTheme: const DividerThemeData(
      indent: AppPadding.p28,
      endIndent: AppPadding.p28,
      thickness: 2,
      color: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(AppSize.borderRadius),
      ),
      isDense: true,
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIconColor: Colors.grey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white70,
        backgroundColor: MyColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),
        textStyle: const TextStyle(fontSize: 18),
      ),
    ),
    textTheme: Typography.whiteHelsinki.copyWith(
      bodySmall: const TextStyle(color: Colors.white),
      titleLarge: TextStyle(
        color: MyColors.lightGrey,
        fontSize: 26,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith(getColor),
      checkColor: MaterialStatePropertyAll(MyColors.primary),
      side: MaterialStateBorderSide.resolveWith((states) => BorderSide.none),
    ),
  );
}
