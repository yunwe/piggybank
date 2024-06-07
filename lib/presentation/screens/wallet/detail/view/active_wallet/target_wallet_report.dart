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
          backgroundColor: MyColors.khakiD1,
          color: MyColors.khakiPrimary,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        Positioned.fill(
          child: Align(
              alignment: Alignment.center,
              child: Text(
                '$percentage%',
                style: Theme.of(context).textTheme.bodySmall,
              )),
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
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: MyColors.textColor,
              ),
        ),
        Row(
          children: [
            Icon(
              Icons.calendar_month,
              size: AppSize.iconSize,
              color: MyColors.textColor,
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
                      Text(
                        AppStrings.endIn.format([report.endIn]),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.textColor,
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                      Text(
                        report.endDate.format(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.textColor,
                            ),
                      ),
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
        Text(
          AppStrings.labelAmountToSave.format([report.targetAmount.toStringAsFixed(2)]),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: MyColors.textColor,
              ),
        ),
        Row(
          children: [
            Icon(
              Icons.attach_money,
              size: AppSize.iconSize,
              color: MyColors.textColor,
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
