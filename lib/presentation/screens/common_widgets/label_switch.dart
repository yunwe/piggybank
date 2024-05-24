import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/resources.dart';

class LabelSwitch extends StatelessWidget {
  const LabelSwitch({
    super.key,
    required this.label,
    required this.isOn,
    required this.onChanged,
  });

  final String label;
  final bool isOn;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: FontSize.inputFontSize,
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Switch(value: isOn, onChanged: onChanged),
      ],
    );
  }
}
