import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/values.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
    this.icon,
    this.hint, {
    super.key,
    this.controller,
    this.errorText,
    this.onChanged,
    this.obscureText = false,
    this.inputType = TextInputType.none,
  });

  final IconData icon;
  final String hint;
  final String? errorText;
  final void Function(String)? onChanged;
  final bool obscureText;
  final TextInputType inputType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        prefixIcon: Icon(
          icon,
          size: AppSize.iconSize,
        ),
      ),
      obscureText: obscureText,
      style: const TextStyle(
        fontSize: FontSize.inputFontSize,
        color: Colors.black87,
      ),
      keyboardType: inputType,
    );
  }
}
