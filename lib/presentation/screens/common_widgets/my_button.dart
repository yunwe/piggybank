import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/colors.dart';

class MyButton extends StatelessWidget {
  const MyButton._({
    super.key,
    required this.onPressed,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.width = double.infinity,
  });

  factory MyButton.primary({Key? key, required onPressed, required label}) {
    return MyButton._(
      key: key,
      onPressed: onPressed,
      label: label,
      backgroundColor: MyColors.primary,
      textColor: MyColors.onPrimary,
    );
  }

  factory MyButton.khaki({Key? key, required onPressed, required label}) {
    return MyButton._(
      key: key,
      onPressed: onPressed,
      label: label,
      backgroundColor: MyColors.khakiPrimary,
      textColor: MyColors.khakiD1,
    );
  }

  final void Function()? onPressed;
  final String label;
  final double width;

  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        key: key,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
        ),
        child: Text(label),
      ),
    );
  }
}
