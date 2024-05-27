import 'package:flutter/material.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';

class ShowError extends StatelessWidget {
  const ShowError({
    super.key,
    required this.failure,
    required this.label,
    required this.onPressed,
  });

  final Failure failure;
  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(failure.message),
          const Spacing.h20(),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
