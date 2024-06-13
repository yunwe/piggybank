import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../bloc/recover_bloc.dart';

class RecoverForm extends StatelessWidget {
  const RecoverForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecoverBloc, RecoverState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.failure.message)),
            );
        }
      },
      child: BlocBuilder<RecoverBloc, RecoverState>(builder: (context, state) {
        if (state.status.isSuccess) {
          return mailSent(context);
        }
        return formContent(context);
      }),
    );
  }

  Widget mailSent(BuildContext context) => Column(
        children: [
          Text('Your email is on the way'),
          Text(
              'Check your email test@test.com and follow the instructions to reset your password'),
          MyButton.primary(
            key: AppKeys.registerSubmit,
            label: AppStrings.labelSignup,
          ),
        ],
      );

  Widget formContent(BuildContext context) => FormContainerWidget(
        backgroundColor: Colors.white.withOpacity(AppSize.opacity),
        content: SizedBox(
          width: AppSize.formEntityWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.forgotPw,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacing.h20(),
              _UsernameInput(),
              const Spacing.h8(),
              _SubmitButton(),
            ],
          ),
        ),
      );
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverBloc, RecoverState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return MyTextField(
            Icons.person,
            AppStrings.hintUserName,
            onChanged: (username) => context.read<RecoverBloc>().add(
                  RecoverUsernameChanged(username),
                ),
            errorText: state.username.displayError?.text(),
          );
        });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverBloc, RecoverState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : MyButton.primary(
                key: AppKeys.registerSubmit,
                onPressed: state.isValid
                    ? () {
                        context.read<RecoverBloc>().add(
                              const RecoverSubmitted(),
                            );
                      }
                    : null,
                label: AppStrings.labelSignup,
              );
      },
    );
  }
}
