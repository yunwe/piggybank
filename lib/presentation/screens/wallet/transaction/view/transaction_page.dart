import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/domain/usecase/get_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/update_amount_usecase.dart';
import '../bloc/wallet_transaction_bloc.dart';
import 'view.dart';

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
      child: _Page(walletId),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page(this.walletId);

  final String walletId;

  @override
  Widget build(BuildContext context) {
    context.read<WalletTransactionBloc>().add(WalletTransactionPageInitialized(walletId));

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
