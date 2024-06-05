import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/resources.dart';

class FormContainerWidget extends StatelessWidget {
  const FormContainerWidget({super.key, required this.content});

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSize.borderRadius),
          ),
          color: Colors.white.withOpacity(AppSize.opacity),
        ),
        padding: const EdgeInsets.all(AppPadding.p28),
        child: SingleChildScrollView(
          child: content,
        ),
      ),
    );
  }
}
