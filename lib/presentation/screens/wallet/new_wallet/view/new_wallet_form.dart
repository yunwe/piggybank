import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/wallet/new_wallet/new_wallet.dart';

class NewWalletForm extends StatelessWidget {
  const NewWalletForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewWalletBloc, NewWalletState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.failure.message)),
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
          _WalletNameInput(),
          const Spacing.h20(),
          _WalletSetTargetInput(),
          const Spacing.h20(),
          _WalletTargetAmountInput(),
          const Spacing.h20(),
          _WalletTargetDateInput(),
          const Spacing.h8(),
          _SubmitButton(),
        ],
      );
}

class _WalletNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewWalletBloc, NewWalletState>(
        buildWhen: (previous, current) => previous.goalName != current.goalName,
        builder: (context, state) {
          return MyTextField(
            Icons.savings,
            'Goal Name',
            key: AppKeys.walletNameInput,
            onChanged: (goalname) => context.read<NewWalletBloc>().add(
                  NewWalletGoalNameChanged(goalName: goalname),
                ),
            errorText: state.goalName.displayError?.text(),
          );
        });
  }
}

class _WalletSetTargetInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewWalletBloc, NewWalletState>(
        buildWhen: (previous, current) => previous.setTarget != current.setTarget,
        builder: (context, state) {
          return LabelSwitch(
            key: AppKeys.walletSetTargetToggle,
            label: AppStrings.labelSetTarget,
            isOn: state.setTarget,
            onChanged: (isOn) => context.read<NewWalletBloc>().add(
                  NewWalletSetTargetChanged(setTarget: isOn),
                ),
          );
        });
  }
}

class _WalletTargetAmountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewWalletBloc, NewWalletState>(
        buildWhen: (previous, current) => previous.setTarget != current.setTarget || previous.targetAmount != current.targetAmount,
        builder: (context, state) {
          if (!state.setTarget) {
            return const SizedBox();
          }
          return MyTextField(
            Icons.attach_money,
            AppStrings.labelTargetAmount,
            key: AppKeys.walletTargetAmount,
            onChanged: (amount) => context.read<NewWalletBloc>().add(
                  NewWalletTargetAmountChanged(targetAmount: amount),
                ),
            errorText: state.targetAmount.displayError?.text(),
          );
        });
  }
}

class _WalletTargetDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewWalletBloc, NewWalletState>(
        buildWhen: (previous, current) => previous.setTarget != current.setTarget || previous.targetDate != current.targetDate,
        builder: (context, state) {
          if (!state.setTarget) {
            return const SizedBox();
          }
          return DatePicker(
            key: AppKeys.walletTargetDate,
            selectedDate: state.targetDate.value,
            onDateChanged: (date) => context.read<NewWalletBloc>().add(
                  NewWalletTargetDateChanged(targetDate: date),
                ),
            error: state.targetDate.displayError?.text(),
          );
        });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewWalletBloc, NewWalletState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : MyButton(
                key: AppKeys.walletCreateSubmit,
                onPressed: state.isValid
                    ? () {
                        context.read<NewWalletBloc>().add(const NewWalletSubmitted());
                      }
                    : null,
                label: AppStrings.labelCreate,
              );
      },
    );
  }
}