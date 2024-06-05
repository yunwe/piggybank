import 'package:flutter/material.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/wallet/detail/view/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/wallet/detail/view/archived_wallet/view.dart';

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
          ArchiveWalletReport(wallet: wallet),
          ElevatedButton(
            onPressed: () => TransactionsList.show(context, transactions),
            child: const Text(AppStrings.viewDetail),
          ),
        ],
      ),
    );
  }
}
