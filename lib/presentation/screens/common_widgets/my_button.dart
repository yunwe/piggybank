import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width = double.infinity,
  });

  final void Function()? onPressed;
  final String label;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        key: key,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
