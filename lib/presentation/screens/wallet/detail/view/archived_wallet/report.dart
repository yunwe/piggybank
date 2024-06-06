import 'package:flutter/material.dart';
import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/app/service/format_string.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../common_widgets/widgets.dart';

//Widget, not a Screen
class ArchiveWalletReport extends StatelessWidget {
  final Wallet wallet;
  const ArchiveWalletReport({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    Report report = Report(wallet: wallet);
    return FormContainerWidget(
      outterPadding: AppPadding.p20,
      innerPadding: 0,
      backgroundColor: MyColors.khakiD1,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ..._buildTargetReport(wallet),
          ReprotIconText(
            icon: Icons.calendar_today,
            title:
                AppStrings.archivedOn.format([wallet.archivedDate!.format()]),
          ),
          divider,
          ReprotIconText(
            icon: Icons.directions_run,
            title: AppStrings.savingPeriod.format([report.activePeriod]),
          ),
          divider,
          ReprotIconText(
            icon: Icons.attach_money,
            title: AppStrings.avgSavingPerM
                .format([report.averageSaving.toStringAsFixed(2)]),
          ),
        ],
      ),
    );
  }

  Widget get divider => const Divider(
        thickness: 2,
        indent: 0,
        endIndent: 0,
      );

  List<Widget> _buildTargetReport(Wallet wallet) {
    if (wallet.targetEndDate == null) return [];

    TargetReport report = TargetReport(wallet: wallet);
    if (report.amountAchievement >= 1) {
      return [
        const ReprotIconText(
          icon: Icons.verified,
          title: AppStrings.succeed,
        ),
        divider,
      ];
    }
    return [
      ReprotIconText(
        icon: Icons.sentiment_very_dissatisfied,
        title: AppStrings.savedPercent
            .format([report.amountAchievement.toStringAsFixed(2)]),
        subTitle: AppStrings.targetAmt
            .format([report.targetAmount.toStringAsFixed(0)]),
      ),
      divider,
    ];
  }
}
