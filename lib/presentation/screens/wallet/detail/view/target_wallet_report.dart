import 'package:flutter/material.dart';
import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/app/service/format_string.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';

//Widget, not a Screen
class TargetWalletReport extends StatelessWidget {
  final Wallet wallet;
  const TargetWalletReport({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    TargetReport report = TargetReport(wallet: wallet);
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TargetAmount(report),
          const Spacing.h20(),
          _ActivePeriod(report),
          const Spacing.h20(),
          const Text(AppStrings.labelSPM),
          Text(AppStrings.labelGoal.format([report.amountToSave.toStringAsFixed(2)])),
          Text(AppStrings.labelCurrent.format([report.amountSaving.toStringAsFixed(2)])),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  //The value should be between 0 .. 100
  final double progress;

  const _ProgressBar(this.progress);

  @override
  Widget build(BuildContext context) {
    int percentage = (progress * 100).toInt();

    return Stack(
      children: [
        LinearProgressIndicator(
          value: progress,
          minHeight: 15,
          backgroundColor: Colors.black,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        Positioned.fill(
          child: Align(alignment: Alignment.center, child: Text('$percentage%')),
        ),
      ],
    );
  }
}

class _ActivePeriod extends StatelessWidget {
  final TargetReport report;

  const _ActivePeriod(this.report);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.labelStartDate.format([report.startDate.format()]),
        ),
        Row(
          children: [
            const Icon(
              Icons.calendar_month,
              size: AppSize.iconSize,
            ),
            const Spacing.w5(),
            Expanded(
              child: Column(
                children: [
                  const Spacing.h8(),
                  _ProgressBar(report.dayAchievement),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.activeFor.format([report.activePeriod])),
                      Text(report.endDate.format()),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _TargetAmount extends StatelessWidget {
  final TargetReport report;

  const _TargetAmount(this.report);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.labelGoal.format([report.targetAmount.toStringAsFixed(2)])),
        Row(
          children: [
            const Icon(
              Icons.attach_money,
              size: AppSize.iconSize,
            ),
            Expanded(
              child: _ProgressBar(report.amountAchievement),
            ),
          ],
        ),
      ],
    );
  }
}
