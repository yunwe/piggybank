import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/colors.dart';
import 'package:piggybank/presentation/resources/values.dart';

class PercentageIcon extends StatelessWidget {
  //value is 0 to 1
  final double percentage;
  final String displayText;

  PercentageIcon(this.percentage, {super.key}) : displayText = '${(percentage * 100).toStringAsFixed(0)}%';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.khakiD2.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(AppPadding.p8),
      child: SizedBox(
        width: AppSize.iconSize,
        height: AppSize.iconSize,
        child: Center(
          child: Stack(
            children: [
              CircularProgressIndicator(
                backgroundColor: MyColors.khakiD2,
                color: Colors.green,
                value: percentage,
              ),
              Center(
                child: Text(
                  displayText,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
