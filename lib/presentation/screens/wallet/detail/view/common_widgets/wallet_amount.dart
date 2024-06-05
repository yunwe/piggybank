import 'package:flutter/material.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';

class WalletAmout extends StatelessWidget {
  final Wallet wallet;

  const WalletAmout(this.wallet, {super.key});

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