import 'package:flutter/material.dart';
import 'package:piggybank/app/route/route.dart';
import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/app/service/format_string.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';

class HomePageItem extends StatelessWidget {
  final Wallet wallet;

  const HomePageItem(this.wallet, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        leading: icon(wallet),
        title: Text(
          wallet.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: MyColors.darkBlue,
              ),
        ),
        subtitle: infoRow(wallet),
        onTap: () {
          AppRouter.router.pushNamed(
            PAGES.walletDetail.screenName,
            pathParameters: {"id": wallet.id},
          );
        },
      ),
    );
  }

  Widget icon(Wallet wallet) {
    double? percentage;
    if (wallet.targetEndDate != null) {
      TargetReport report = TargetReport(wallet: wallet);
      percentage = report.amountAchievement;
    }

    bool isValidIcon = wallet.icon >= 0 && wallet.icon < IconType.values.length;
    IconType type =
        isValidIcon ? IconType.values[wallet.icon] : IconType.saving;

    return ColorIcon(
      iconType: type,
      percentage: percentage,
    );
  }

  Widget infoRow(Wallet wallet) {
    if (wallet.targetEndDate != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          info(Icons.attach_money, wallet.amount.formatCurrency()),
          info(Icons.calendar_today, wallet.targetEndDate!.formatMonth()),
        ],
      );
    }

    return info(Icons.attach_money, wallet.amount.formatCurrency());
  }

  Widget info(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppSize.iconSizeXS,
        ),
        const Spacing.w5(),
        Text(text),
      ],
    );
  }
}
