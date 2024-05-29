import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/wallet/transaction/bloc/wallet_transaction_bloc.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({super.key, required this.walletId});

  final String walletId;

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
          AppRouter.router.goNamed(PAGES.walletDetail.screenName);

          AppRouter.router.pushNamed(
            PAGES.walletDetail.screenName,
            pathParameters: {"id": walletId},
          );
        }
      },
      child: formContent(context),
    );
  }

  Widget formContent(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _AmountInput(),
          const Spacing.h20(),
          _RemarkInput(),
          const Spacing.h20(),
          _SubmitButton(),
          const Spacing.h20(),
          _ModeInput(),
        ],
      );
}

class _AmountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletTransactionBloc, WalletTransactionState>(
        buildWhen: (previous, current) => previous.amount != current.amount,
        builder: (context, state) {
          return MyTextField(
            Icons.attach_money,
            AppStrings.hintAmount,
            inputType: TextInputType.number,
            onChanged: (amount) => context.read<WalletTransactionBloc>().add(
                  WalletTransactionAmountChanged(amount),
                ),
            errorText: state.amount.displayError?.text(),
          );
        });
  }
}

class _RemarkInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyTextField(
      Icons.edit_note_rounded,
      AppStrings.hintRemark,
      onChanged: (remark) => context.read<WalletTransactionBloc>().add(
            WalletTransactionRemarkChanged(remark),
          ),
    );
  }
}

class _ModeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletTransactionBloc, WalletTransactionState>(
        buildWhen: (previous, current) => previous.isWithdrawl != current.isWithdrawl,
        builder: (context, state) {
          return TextButton(
            onPressed: () {
              context.read<WalletTransactionBloc>().add(
                    WalletTransactionModeChanged(!state.isWithdrawl),
                  );
            },
            child: Text(
              state.isWithdrawl ? AppStrings.labelSaving : AppStrings.labelWithdrawl,
              // style: TextStyle(
              //   color: Theme.of(context).colorScheme.onPrimaryContainer,
              //   decoration: TextDecoration.underline,
              //   decorationColor: Theme.of(context).colorScheme.onPrimaryContainer,
              // ),
            ),
          );
        });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletTransactionBloc, WalletTransactionState>(
      buildWhen: (previous, current) => previous.isWithdrawl != current.isWithdrawl,
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : MyButton(
                onPressed: state.isValid
                    ? () {
                        context.read<WalletTransactionBloc>().add(const WalletTransactionSubmitted());
                      }
                    : null,
                label: state.isWithdrawl ? AppStrings.labelWithdrawlButton : AppStrings.labelSavingButton,
              );
      },
    );
  }
}
