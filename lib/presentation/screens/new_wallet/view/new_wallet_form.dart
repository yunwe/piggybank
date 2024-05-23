import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/auth/login/login.dart';
import 'package:piggybank/presentation/screens/new_wallet/new_wallet.dart';

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

  Widget formContent(BuildContext context) => FormContainerWidget(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.titleSignin,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            spaceP20,
            _WalletNameInput(),
            spaceP20,
            _SubmitButton(),
          ],
        ),
      );

  Widget get spaceP20 => const SizedBox(
        height: AppPadding.p20,
      );

  Widget get spaceP8 => const SizedBox(
        height: AppPadding.p8,
      );
}

class _WalletNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewWalletBloc, NewWalletState>(
        buildWhen: (previous, current) => previous.goalName != current.goalName,
        builder: (context, state) {
          return MyTextField(
            Icons.person,
            AppStrings.hintUserName,
            key: AppKeys.loginUsername,
            onChanged: (goalname) => context.read<NewWalletBloc>().add(
                  NewWalletGoalNameChanged(goalName: goalname),
                ),
            errorText: state.goalName.displayError?.text(),
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
                key: AppKeys.loginSubmit,
                onPressed: state.isValid
                    ? () {
                        context.read<NewWalletBloc>().add(const NewWalletSubmitted());
                      }
                    : null,
                label: AppStrings.labelLogin,
              );
      },
    );
  }
}
