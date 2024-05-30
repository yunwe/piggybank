import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/wallet/transaction/bloc/wallet_transaction_bloc.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({super.key, required this.walletId});

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
      child: content(context),
    );
  }

  Widget content(BuildContext context) => Scaffold(
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
    return TextFormField(
      decoration: const InputDecoration(
        hintText: AppStrings.hintRemark,
        prefixIcon: Icon(
          Icons.short_text,
          size: AppSize.iconSize,
        ),
      ),
      style: const TextStyle(
        fontSize: FontSize.inputFontSize,
        color: Colors.black87,
      ),
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
