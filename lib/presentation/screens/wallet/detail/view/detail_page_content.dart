import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/wallet/detail/detail.dart';
import 'package:piggybank/presentation/screens/wallet/detail/view/detail_page_appbar.dart';
import 'package:piggybank/presentation/screens/wallet/detail/view/target_wallet_report.dart';
import 'package:piggybank/presentation/screens/wallet/detail/view/wallet_report.dart';

class DetialPageContent extends StatelessWidget {
  const DetialPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletDetailBloc, WalletDetialState>(builder: (context, state) {
      if (state.wallet == null) {
        if (state.status == DetailPageStatus.processing) {
          return const FullPageLoading();
        }

        return ShowError.noWallet();
      }

      return content(state.wallet!, state.transactions);
    });
  }

  Widget content(Wallet wallet, List<Transaction> transactions) => Scaffold(
        backgroundColor: MyColors.primary,
        appBar: const DetailPageAppbar(),
        body: Column(
          children: [
            _WalletInfo(wallet),
            wallet.targetEndDate == null ? WalletReport(wallet: wallet) : TargetWalletReport(wallet: wallet),
            Expanded(
              child: _TransactionsList(transactions),
            )
          ],
        ),
        floatingActionButton: wallet.isArchived
            ? null
            : FloatingActionButton(
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

class _WalletInfo extends StatelessWidget {
  final Wallet wallet;

  const _WalletInfo(this.wallet);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('\$${wallet.amount}'),
            const Text(AppStrings.labelTotal),
          ],
        ),
      ),
    );
  }
}

class _TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const _TransactionsList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: transactions.isEmpty
          ? const Center(child: Text(AppStrings.noHistory))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(AppStrings.labelHistory),
                const Spacing.h8(),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => _TransactionItem(transactions[index]),
                    itemCount: transactions.length,
                  ),
                ),
              ],
            ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const _TransactionItem(this.transaction);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            block(
              transaction.amount.toString(),
              transaction.createdTime.format(),
            ),
            block(
              transaction.updatedBalance.toString(),
              AppStrings.labelBalance,
            ),
            if (transaction.amount < 0)
              const Icon(Icons.arrow_drop_down, color: Colors.red)
            else
              const Icon(Icons.arrow_drop_up, color: Colors.green),
          ],
        ),
        if (transaction.remarks != null && transaction.remarks!.trim() != '') remark(transaction.remarks!),
        const Spacing.h12(),
      ],
    );
  }

  Widget block(String l1, String l2) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l1,
            // style: Theme.of(ctx).textTheme.bodyMedium!.copyWith(
            //       color: Theme.of(ctx).colorScheme.onBackground,
            //     ),
          ),
          Text(
            l2,
            // style: Theme.of(ctx).textTheme.bodySmall!.copyWith(
            //       color: Theme.of(ctx).colorScheme.onBackground,
            //     ),
          ),
        ],
      );

  Widget remark(String remark) => Row(
        children: [
          const Icon(
            Icons.info_outline,
            size: AppSize.iconSizeXS,
          ),
          const Spacing.w5(),
          Text(
            remark,
            // style: Theme.of(ctx).textTheme.bodySmall!.copyWith(
            //       color: Theme.of(ctx).colorScheme.onBackground,
            //     ),
          ),
        ],
      );
}
