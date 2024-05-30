import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/domain/usecase/get_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/update_amount_usecase.dart';
import 'package:piggybank/presentation/screens/wallet/transaction/bloc/wallet_transaction_bloc.dart';
import 'package:piggybank/presentation/screens/wallet/transaction/view/transaction_form.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({
    super.key,
    required this.walletId,
  });

  final String walletId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletTransactionBloc(
        updateUseCase: injector<UpdateAmountUseCase>(),
        getUseCase: injector<GetWalletUseCase>(),
      ),
      child: TransactionForm(walletId: walletId),
    );
  }
}
