import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/update_amount_usecase.dart';
import '../bloc/wallet_transaction_bloc.dart';
import 'view.dart';

// Call from Wallet Detial Page
class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  static Future<Wallet?> show(BuildContext context, Wallet wallet) async {
    //If the updated wallet is not return,
    //the wallet detail page will have to get it from cache,
    //the cache might not be updated yet.
    final result = await Navigator.of(context).push(
      MaterialPageRoute<Wallet>(
        fullscreenDialog: true,
        builder: (context) => BlocProvider(
          create: (context) => WalletTransactionBloc(
            wallet: wallet,
            updateUseCase: injector<UpdateAmountUseCase>(),
          ),
          child: const TransactionPage(),
        ),
      ),
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletTransactionBloc, WalletTransactionState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.failure.message)),
            );
        }
        if (state.status.isSuccess) {
          Navigator.of(context).pop(state.wallet);

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
        }
      },
      child: const TransactionForm(),
    );
  }
}
