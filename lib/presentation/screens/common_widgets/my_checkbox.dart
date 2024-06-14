import 'package:flutter/material.dart';
import 'package:piggybank/presentation/screens/common_widgets/spacing.dart';

class MyCheckbox extends StatelessWidget {
  final String label;
  final bool isChecked;
  final void Function(bool?)? onChanged;

  const MyCheckbox({
    super.key,
    required this.label,
    required this.isChecked,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20,
          height: 25,
          child: Checkbox(
            value: isChecked,
            onChanged: onChanged,
          ),
        ),
        const Spacing.w5(),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
