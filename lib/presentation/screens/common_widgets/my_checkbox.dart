import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  final String label;

  const MyCheckbox({super.key, required this.label});

  @override
  State<StatefulWidget> createState() => MyCheckboxState();
}

class MyCheckboxState extends State<MyCheckbox> {
  bool? isChecked = true;

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
            onChanged: (newValue) {
              setState(() {
                isChecked = newValue;
              });
            },
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
