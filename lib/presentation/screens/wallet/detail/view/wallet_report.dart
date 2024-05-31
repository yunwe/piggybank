import 'package:flutter/material.dart';
import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/app/service/format_string.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';

//Widget, not a Screen
class WalletReport extends StatelessWidget {
  final Wallet wallet;
  const WalletReport({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    Report report = Report(wallet: wallet);
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _IconText(
            icon: Icons.calendar_today,
            text: AppStrings.startedOn.format([report.startDate.format()]),
          ),
          const Spacing.h8(),
          _IconText(
            icon: Icons.directions_run,
            text: AppStrings.activeFor.format([report.activePeriod]),
          ),
          const Spacing.h8(),
          if (report.currentAmount > 0)
            _IconText(
              icon: Icons.savings_outlined,
              text: AppStrings.avgSaving.format([report.averageSaving.toStringAsFixed(2)]),
            ),
        ],
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppSize.bulletinSize,
        ),
        const Spacing.w5(),
        Text(text),
      ],
    );
  }
}
