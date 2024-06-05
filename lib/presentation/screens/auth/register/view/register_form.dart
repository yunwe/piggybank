import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../bloc/register_bloc.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
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
        content: SizedBox(
          width: AppSize.formEntityWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.titleRegister,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacing.h20(),
              _UsernameInput(),
              const Spacing.h20(),
              _PasswordInput(),
              const Spacing.h20(),
              _ConfirmPasswordInput(),
              const Spacing.h8(),
              _RegisterButton(),
            ],
          ),
        ),
      );
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return MyTextField(
            Icons.person,
            AppStrings.hintUserName,
            key: AppKeys.registerUsername,
            onChanged: (username) => context.read<RegisterBloc>().add(
                  RegisterUsernameChanged(username),
                ),
            errorText: state.username.displayError?.text(),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return MyTextField(
            Icons.lock,
            AppStrings.hintPw,
            key: AppKeys.registerPassword,
            onChanged: (password) => context.read<RegisterBloc>().add(
                  RegisterPasswordChanged(password),
                ),
            obscureText: true,
            errorText: state.password.displayError?.text(),
          );
        });
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password || previous.confirmation != current.confirmation,
      builder: (context, state) {
        return MyTextField(
          Icons.lock,
          AppStrings.hintConfirmPw,
          key: AppKeys.registerConfirmPassword,
          onChanged: (confirmPassword) => context.read<RegisterBloc>().add(
                RegisterConfirmPasswordChanged(confirmPassword),
              ),
          obscureText: true,
          errorText: state.confirmation.displayError?.text(),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : MyButton(
                key: AppKeys.registerSubmit,
                onPressed: state.isValid
                    ? () {
                        context.read<RegisterBloc>().add(
                              const RegisterSubmitted(),
                            );
                      }
                    : null,
                label: AppStrings.labelSignup,
              );
      },
    );
  }
}
