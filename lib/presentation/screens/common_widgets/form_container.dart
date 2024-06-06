import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/resources.dart';

class FormContainerWidget extends StatelessWidget {
  const FormContainerWidget({
    super.key,
    required this.content,
    this.backgroundColor = Colors.white,
    this.outterPadding = AppPadding.p28,
    this.innerPadding = AppPadding.p28,
  });

  final Widget content;
  final Color backgroundColor;
  final double outterPadding;
  final double innerPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: outterPadding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSize.borderRadius),
          ),
          color: backgroundColor.withOpacity(AppSize.opacity),
        ),
        padding: EdgeInsets.all(innerPadding),
        child: SingleChildScrollView(
          child: content,
        ),
      ),
    );
  }
}
