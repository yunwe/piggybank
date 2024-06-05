import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';

class ReprotIconText extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subTitle;

  const ReprotIconText({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: AppSize.bulletinSize,
        ),
        const Spacing.w5(),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            if (subTitle != null) Text(subTitle!),
          ],
        ),
      ],
    );
  }
}
