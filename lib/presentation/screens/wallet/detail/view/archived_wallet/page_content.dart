import 'package:flutter/material.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../common_widgets/widgets.dart';
import 'view.dart';

class PageContent extends StatelessWidget {
  const PageContent({
    super.key,
    required this.isProcessing,
    required this.wallet,
    required this.transactions,
  });

  final bool isProcessing;
  final Wallet wallet;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.khaki,
      appBar: const DetailPageAppbar(),
      body: Stack(
        children: [
          Column(
            children: [
              WalletAmout(wallet),
              const Spacing.h20(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => TransactionsList.show(context, transactions),
                  icon: Icon(
                    Icons.read_more,
                    color: MyColors.textColor,
                  ),
                  label: Text(AppStrings.viewDetail,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
              ArchiveWalletReport(wallet: wallet),
            ],
          ),
          isProcessing ? const Positioned(child: Loading()) : const SizedBox(),
        ],
      ),
    );
  }
}
