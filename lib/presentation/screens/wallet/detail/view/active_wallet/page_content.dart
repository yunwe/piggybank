import 'package:flutter/material.dart';
import 'package:piggybank/app/route/route.dart';
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
              wallet.targetEndDate == null
                  ? WalletReport(wallet: wallet)
                  : TargetWalletReport(wallet: wallet),
              VisualReport(wallet: wallet, transactions: transactions),
            ],
          ),
          isProcessing ? const Positioned(child: Loading()) : const SizedBox(),
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
