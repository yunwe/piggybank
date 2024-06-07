import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/colors.dart';

class MyButton extends StatelessWidget {
  const MyButton._({
    super.key,
    required this.onPressed,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.fullWidth,
  });

  factory MyButton.primary({Key? key, void Function()? onPressed, required String label}) {
    return MyButton._(
      key: key,
      onPressed: onPressed,
      label: label,
      backgroundColor: MyColors.primary,
      textColor: MyColors.onPrimary,
      fullWidth: true,
    );
  }

  factory MyButton.khakiPrimary({Key? key, void Function()? onPressed, required String label}) {
    return MyButton._(
      key: key,
      onPressed: onPressed,
      label: label,
      backgroundColor: MyColors.khakiPrimary,
      textColor: MyColors.khakiD1,
      fullWidth: true,
    );
  }

  factory MyButton.khaki({Key? key, void Function()? onPressed, required String label}) {
    return MyButton._(
      key: key,
      onPressed: onPressed,
      label: label,
      backgroundColor: MyColors.khakiD1,
      textColor: MyColors.textColor,
      fullWidth: false,
    );
  }

  final void Function()? onPressed;
  final String label;
  final bool fullWidth;

  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    ElevatedButton button = ElevatedButton(
      key: key,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
      child: Text(label),
    );
    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}
