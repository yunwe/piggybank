import 'package:flutter/material.dart';
import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/presentation/resources/resources.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    this.selectedDate,
    required this.onDateChanged,
    this.error,
  });

  final DateTime? selectedDate;
  final void Function(DateTime?) onDateChanged;
  final String? error;

  void _openDatePicer(BuildContext context) async {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    final threeYears = now.add(const Duration(days: 365 * 3));

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: tomorrow,
      lastDate: threeYears,
    );
    onDateChanged(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: TextFormField(
            controller: TextEditingController()..text = selectedDate == null ? '' : selectedDate!.format(),
            decoration: InputDecoration(
              hintText: AppStrings.selectDate,
              errorText: error,
              prefixIcon: const Icon(
                Icons.calendar_month,
                size: AppSize.iconSize,
              ),
            ),
            style: const TextStyle(
              fontSize: FontSize.inputFontSize,
              color: Colors.black87,
            ),
            readOnly: true,
            onTap: () => _openDatePicer(context),
          ),
        ),
        ElevatedButton(
          onPressed: () => _openDatePicer(context),
          child: const Text(AppStrings.selectDate),
        ),
      ],
    );
  }
}
