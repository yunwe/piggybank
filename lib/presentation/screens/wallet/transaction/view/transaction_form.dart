import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../bloc/wallet_transaction_bloc.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.khaki,
      appBar: AppBar(title: _Title()),
      body: Padding(
        padding: const EdgeInsets.only(top: AppPadding.p20),
        child: Column(
          children: [
            FormContainerWidget(
              outterPadding: AppPadding.p8,
              innerPadding: AppPadding.p20,
              backgroundColor: MyColors.khakiD1,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _AmountInput(),
                  const Spacing.h20(),
                  _RemarkInput(),
                  const Spacing.h20(),
                  _SubmitButton(),
                ],
              ),
            ),
            const Spacing.h8(),
            Divider(
              color: MyColors.khakiD1,
              endIndent: AppPadding.p8,
              indent: AppPadding.p8,
              thickness: 2,
            ),
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
          return Text(state.wallet.title);
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
          return TextButton.icon(
            onPressed: () {
              context.read<WalletTransactionBloc>().add(
                    WalletTransactionModeChanged(!state.isWithdrawl),
                  );
            },
            icon: Icon(
              state.isWithdrawl ? Icons.savings : Icons.heart_broken_outlined,
              color: MyColors.khakiD2,
            ),
            label: Text(
              state.isWithdrawl ? AppStrings.labelSaving : AppStrings.labelWithdrawl,
              style: TextStyle(
                color: MyColors.khakiD2,
              ),
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
            : MyButton.khakiPrimary(
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
