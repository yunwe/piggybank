import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/resources.dart';

class LabelSwitch extends StatelessWidget {
  const LabelSwitch({
    super.key,
    required this.label,
    required this.isOn,
    required this.onChanged,
    this.textColor,
    this.activeColor,
    this.inactiveColor,
  });

  final String label;
  final Color? textColor;
  final Color? activeColor;
  final Color? inactiveColor;

  final bool isOn;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: FontSize.medium,
            color: textColor,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Switch(
          value: isOn,
          onChanged: onChanged,
          activeColor: activeColor,
          inactiveTrackColor: inactiveColor,
        ),
      ],
    );
  }
}
