import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/colors.dart';
import 'package:piggybank/presentation/resources/values.dart';

enum IconType {
  success,
  failed,
  fastFood,
  ramen,
  home,
  furniture,
  appliance,
  birthday,
  shopping,
  car,
  bike,
  yoga,
  school,
  child,
  trip,
  saving,
}

extension IconTypeExtension on IconType {
  IconData get icon {
    switch (this) {
      case IconType.success:
        return Icons.verified;
      case IconType.failed:
        return Icons.sentiment_very_dissatisfied;
      case IconType.fastFood:
        return Icons.fastfood;
      case IconType.ramen:
        return Icons.ramen_dining;
      case IconType.home:
        return Icons.villa;
      case IconType.furniture:
        return Icons.chair;
      case IconType.appliance:
        return Icons.countertops;
      case IconType.birthday:
        return Icons.cake;
      case IconType.shopping:
        return Icons.shopping_cart;
      case IconType.car:
        return Icons.directions_car;
      case IconType.bike:
        return Icons.two_wheeler;
      case IconType.yoga:
        return Icons.self_improvement;
      case IconType.school:
        return Icons.school;
      case IconType.child:
        return Icons.child_friendly;
      case IconType.trip:
        return Icons.landscape;
      case IconType.saving:
        return Icons.account_balance;
    }
  }

  Color get color {
    switch (this) {
      case IconType.success:
        return Colors.green;
      case IconType.failed:
        return Colors.red;
      case IconType.fastFood:
        return Colors.orange;
      case IconType.ramen:
        return Colors.deepOrange;
      case IconType.home:
        return Colors.blueGrey;
      case IconType.furniture:
        return Colors.brown;
      case IconType.appliance:
        return Colors.green.shade900;
      case IconType.birthday:
        return Colors.pink;
      case IconType.shopping:
        return Colors.blue;
      case IconType.car:
        return Colors.deepPurple;
      case IconType.bike:
        return Colors.teal;
      case IconType.yoga:
        return Colors.amber;
      case IconType.school:
        return Colors.purple;
      case IconType.child:
        return Colors.cyan;
      case IconType.trip:
        return Colors.green;
      case IconType.saving:
        return MyColors.darkBlue;
    }
  }
}

class ColorIcon extends StatelessWidget {
  const ColorIcon({super.key, required this.iconType, this.percentage});

  final IconType iconType;

  //value is 0 to 1
  final double? percentage;

  @override
  Widget build(BuildContext context) {
    return percentage == null ? normal : percentageIcon;
  }

  Widget get normal => Container(
        decoration: BoxDecoration(
          color: iconType.color.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Icon(
          iconType.icon,
          color: iconType.color,
          size: AppSize.iconSize,
        ),
      );

  Widget get percentageIcon => SizedBox(
        width: AppSize.iconSize + AppPadding.p8,
        height: AppSize.iconSize + AppPadding.p8,
        child: Center(
          child: Stack(
            children: [
              CircularProgressIndicator(
                backgroundColor: MyColors.khakiD2,
                color: iconType.color,
                value: percentage,
              ),
              Center(
                  child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 3,
                    left: 0,
                    right: 0,
                    child: Icon(
                      iconType.icon,
                      //color: MyColors.khakiD2.withOpacity(AppSize.opacity),
                      color: iconType.color,
                      size: AppSize.iconSizeXS,
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    left: 0,
                    right: 0,
                    child: Text(
                      '${(percentage! * 100).toStringAsFixed(0)}%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: iconType.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  // Stroked text as border.

                  // Solid text as fill.
                ],
              )),
            ],
          ),
        ),
      );
}
