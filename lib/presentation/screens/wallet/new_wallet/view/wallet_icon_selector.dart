import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/color_icon.dart';
import 'package:piggybank/presentation/screens/common_widgets/spacing.dart';

class WalletIconSelector extends StatefulWidget {
  const WalletIconSelector({
    super.key,
    required this.selectedIcon,
    required this.onUpdated,
  });

  static const List<IconType> iconList = [
    IconType.fastFood,
    IconType.ramen,
    IconType.home,
    IconType.furniture,
    IconType.appliance,
    IconType.birthday,
    IconType.shopping,
    IconType.car,
    IconType.bike,
    IconType.yoga,
    IconType.school,
    IconType.child,
    IconType.trip,
    IconType.saving,
  ];

  final IconType selectedIcon;
  final void Function(IconType) onUpdated;

  @override
  State<WalletIconSelector> createState() => _WalletIconSelectorState();
}

class _WalletIconSelectorState extends State<WalletIconSelector> {
  bool isSelecting = false;

  @override
  Widget build(BuildContext context) {
    if (isSelecting == false) {
      return Row(
        children: [
          Text(
            'Selected Icon',
            style: TextStyle(
              fontSize: FontSize.medium,
              color: MyColors.textColor,
            ),
          ),
          const Spacing.w15(),
          IconButton(
            onPressed: () {
              setState(() {
                isSelecting = true;
              });
            },
            icon: ColorIcon(iconType: widget.selectedIcon),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Icon',
              style: TextStyle(
                fontSize: FontSize.medium,
                color: MyColors.textColor,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isSelecting = false;
                });
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        const Spacing.h8(),
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: AppPadding.p20,
            runSpacing: 12,
            children: WalletIconSelector.iconList
                .map(
                  (icon) => GestureDetector(
                    onTap: () {
                      widget.onUpdated(icon);
                    },
                    child: icon == widget.selectedIcon
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColors.primaryD2,
                                width: 3,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: ColorIcon(iconType: icon),
                          )
                        : ColorIcon(iconType: icon),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
