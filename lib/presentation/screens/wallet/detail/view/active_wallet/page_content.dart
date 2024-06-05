import 'package:flutter/material.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/wallet/detail/view/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/wallet/detail/view/active_wallet/view.dart';

class PageContent extends StatelessWidget {
  const PageContent({
    super.key,
    required this.wallet,
    required this.transactions,
  });

  final Wallet wallet;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: const DetailPageAppbar(),
      body: Column(
        children: [
          WalletAmout(wallet),
          wallet.targetEndDate == null ? WalletReport(wallet: wallet) : TargetWalletReport(wallet: wallet),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(AppStrings.titleMonthlyReport),
                GestureDetector(
                  onTap: () => TransactionsList.show(context, transactions),
                  child: const Text(AppStrings.viewDetail),
                )
              ],
            ),
          ),
          const Spacing.h12(),
          VisualReport(wallet: wallet, transactions: transactions),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.router.pushNamed(
            PAGES.walletTransaction.screenName,
            pathParameters: {'wallet': wallet.id},
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
