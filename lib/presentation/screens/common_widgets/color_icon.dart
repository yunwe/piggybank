import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/values.dart';

class ColorIcon extends StatelessWidget {
  const ColorIcon({super.key, required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Icon(
        icon,
        color: color,
        size: AppSize.iconSize,
      ),
    );
  }
}
