import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../bloc/new_wallet_bloc.dart';

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
        if (state.status.isSuccess) {
          AppRouter.router.goNamed(PAGES.walletList.screenName);
        }
      },
      child: formContent(context),
    );
  }

  Widget formContent(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: AppPadding.p20),
        child: FormContainerWidget(
          outterPadding: AppPadding.p8,
          innerPadding: AppPadding.p20,
          backgroundColor: MyColors.khakiD1,
          content: Column(
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
          ),
        ),
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
        buildWhen: (previous, current) =>
            previous.setTarget != current.setTarget,
        builder: (context, state) {
          return LabelSwitch(
            key: AppKeys.walletSetTargetToggle,
            label: AppStrings.labelSetTarget,
            isOn: state.setTarget,
            onChanged: (isOn) => context.read<NewWalletBloc>().add(
                  NewWalletSetTargetChanged(setTarget: isOn),
                ),
            textColor: MyColors.textColor,
            activeColor: MyColors.khakiD2,
            inactiveColor: MyColors.khakiD1,
          );
        });
  }
}

class _WalletTargetAmountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewWalletBloc, NewWalletState>(
        buildWhen: (previous, current) =>
            previous.setTarget != current.setTarget ||
            previous.targetAmount != current.targetAmount,
        builder: (context, state) {
          if (!state.setTarget) {
            return const SizedBox();
          }
          return MyTextField(
            Icons.attach_money,
            AppStrings.labelTargetAmount,
            inputType: TextInputType.number,
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
        buildWhen: (previous, current) =>
            previous.setTarget != current.setTarget ||
            previous.targetDate != current.targetDate,
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
            : MyButton.khakiPrimary(
                key: AppKeys.walletCreateSubmit,
                onPressed: state.isValid
                    ? () {
                        context
                            .read<NewWalletBloc>()
                            .add(const NewWalletSubmitted());
                      }
                    : null,
                label: AppStrings.labelCreate,
              );
      },
    );
  }
}
