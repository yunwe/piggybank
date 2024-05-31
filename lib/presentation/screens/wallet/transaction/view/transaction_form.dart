import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/wallet/transaction/bloc/wallet_transaction_bloc.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(title: _Title()),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
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
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletTransactionBloc, WalletTransactionState>(
        buildWhen: (previous, current) => previous.wallet != current.wallet,
        builder: (context, state) {
          if (state.wallet == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Text(state.wallet!.title);
        });
  }
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
    return BlocBuilder<WalletTransactionBloc, WalletTransactionState>(
        buildWhen: (previous, current) => previous.remark != current.remark,
        builder: (context, state) {
          return MyTextField(
            Icons.short_text,
            AppStrings.hintRemark,
            onChanged: (remark) => context.read<WalletTransactionBloc>().add(
                  WalletTransactionRemarkChanged(remark),
                ),
            errorText: state.remark.displayError?.text(),
          );
        });
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
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : MyButton(
                onPressed: state.isValid
                    ? () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<WalletTransactionBloc>().add(const WalletTransactionSubmitted());
                      }
                    : null,
                label: state.isWithdrawl ? AppStrings.labelWithdrawlButton : AppStrings.labelSavingButton,
              );
      },
    );
  }
}
