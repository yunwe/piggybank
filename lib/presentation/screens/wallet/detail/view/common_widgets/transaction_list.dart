import 'package:flutter/material.dart';
import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionsList(this.transactions, {super.key});

  static void show(BuildContext context, List<Transaction> transactions) {
    showModalBottomSheet(
        context: context,
        backgroundColor: MyColors.primary,
        builder: (BuildContext context) {
          return TransactionsList(transactions);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p28),
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
