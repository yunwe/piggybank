import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/domain/usecase/update_amount_usecase.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/wallet/transaction/bloc/wallet_transaction_bloc.dart';
import 'package:piggybank/presentation/screens/wallet/transaction/view/transaction_form.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key, required this.walletId});

  final String walletId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        title: const Text(AppStrings.titleUpdate),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: form(context),
      ),
    );
  }

  Widget form(BuildContext context) => BlocProvider(
        create: (context) => WalletTransactionBloc(
          useCase: injector<UpdateAmountUseCase>(),
          walletId: walletId,
        ),
        child: TransactionForm(walletId: walletId),
      );
}
