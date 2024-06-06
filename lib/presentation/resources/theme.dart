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
    colorScheme: MyColors.colorScheme,
    dividerTheme: DividerThemeData(
      indent: AppPadding.p28,
      endIndent: AppPadding.p28,
      thickness: 2,
      color: Colors.white.withOpacity(AppSize.opacity),
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
        foregroundColor: MyColors.onPrimary,
        backgroundColor: MyColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),
        textStyle: const TextStyle(fontSize: FontSize.medium),
      ),
    ),
    textTheme: Typography.whiteHelsinki.copyWith(
      bodySmall: TextStyle(color: MyColors.textColor),
      bodyMedium: TextStyle(color: MyColors.textColor),
      titleMedium: TextStyle(color: MyColors.textColor),
      titleLarge: TextStyle(
        color: MyColors.onPrimary,
        fontSize: FontSize.extraLarge,
        fontWeight: FontWeight.bold,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith(getColor),
      checkColor: MaterialStatePropertyAll(MyColors.onWhite),
      side: MaterialStateBorderSide.resolveWith((states) => BorderSide.none),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 4,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: FontSize.large,
        color: MyColors.textColor,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: MyColors.textColor,
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: MyColors.onPrimary,
      titleTextStyle: TextStyle(
        fontSize: FontSize.medium,
        color: MyColors.onPrimary,
      ),
    ),
  );
}
