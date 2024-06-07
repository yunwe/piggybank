import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/colors.dart';
import 'package:piggybank/presentation/resources/values.dart';

enum ColorIconType {
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

class ColorIcon extends StatelessWidget {
  const ColorIcon._({required this.color, required this.icon});

  factory ColorIcon.success() {
    return const ColorIcon._(
      color: Colors.green,
      icon: Icons.verified,
    );
  }

  factory ColorIcon.failed() {
    return const ColorIcon._(
      color: Colors.red,
      icon: Icons.sentiment_very_dissatisfied,
    );
  }

  factory ColorIcon.fastFood() {
    return const ColorIcon._(
      color: Colors.orange,
      icon: Icons.fastfood,
    );
  }

  factory ColorIcon.ramen() {
    return const ColorIcon._(
      color: Colors.deepOrange,
      icon: Icons.ramen_dining,
    );
  }

  factory ColorIcon.home() {
    return const ColorIcon._(
      color: Colors.blueGrey,
      icon: Icons.villa,
    );
  }

  factory ColorIcon.furniture() {
    return const ColorIcon._(
      color: Colors.brown,
      icon: Icons.chair,
    );
  }

  factory ColorIcon.appliance() {
    return ColorIcon._(
      color: Colors.green.shade900,
      icon: Icons.countertops,
    );
  }

  factory ColorIcon.birthday() {
    return const ColorIcon._(
      color: Colors.pink,
      icon: Icons.cake,
    );
  }

  factory ColorIcon.shopping() {
    return const ColorIcon._(
      color: Colors.blue,
      icon: Icons.shopping_cart,
    );
  }

  factory ColorIcon.car() {
    return const ColorIcon._(
      color: Colors.deepPurple,
      icon: Icons.directions_car,
    );
  }

  factory ColorIcon.bike() {
    return const ColorIcon._(
      color: Colors.teal,
      icon: Icons.two_wheeler,
    );
  }

  factory ColorIcon.yoga() {
    return const ColorIcon._(
      color: Colors.amber,
      icon: Icons.self_improvement,
    );
  }

  factory ColorIcon.school() {
    return const ColorIcon._(
      color: Colors.purple,
      icon: Icons.school,
    );
  }

  factory ColorIcon.child() {
    return const ColorIcon._(
      color: Colors.cyan,
      icon: Icons.child_friendly,
    );
  }

  factory ColorIcon.trip() {
    return const ColorIcon._(
      color: Colors.green,
      icon: Icons.landscape,
    );
  }

  factory ColorIcon.saving() {
    return ColorIcon._(
      color: MyColors.darkBlue,
      icon: Icons.account_balance,
    );
  }

  factory ColorIcon.fromType(ColorIconType type) {
    switch (type) {
      case ColorIconType.success:
        return ColorIcon.success();
      case ColorIconType.failed:
        return ColorIcon.failed();
      case ColorIconType.fastFood:
        return ColorIcon.fastFood();
      case ColorIconType.ramen:
        return ColorIcon.ramen();
      case ColorIconType.home:
        return ColorIcon.home();
      case ColorIconType.furniture:
        return ColorIcon.furniture();
      case ColorIconType.appliance:
        return ColorIcon.appliance();
      case ColorIconType.birthday:
        return ColorIcon.birthday();
      case ColorIconType.shopping:
        return ColorIcon.shopping();
      case ColorIconType.car:
        return ColorIcon.car();
      case ColorIconType.bike:
        return ColorIcon.bike();
      case ColorIconType.yoga:
        return ColorIcon.yoga();
      case ColorIconType.school:
        return ColorIcon.school();
      case ColorIconType.child:
        return ColorIcon.child();
      case ColorIconType.trip:
        return ColorIcon.trip();
      case ColorIconType.saving:
        return ColorIcon.saving();
      default:
        return ColorIcon.success();
    }
  }

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
