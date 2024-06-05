import 'package:flutter/material.dart';
import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/app/service/format_string.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../common_widgets/widgets.dart';

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
          ReprotIconText(
            icon: Icons.calendar_today,
            title: AppStrings.startedOn.format([report.startDate.format()]),
          ),
          const Spacing.h8(),
          ReprotIconText(
            icon: Icons.directions_run,
            title: AppStrings.activeFor.format([report.activePeriod]),
          ),
        ],
      ),
    );
  }
}
