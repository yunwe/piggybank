import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
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
        backgroundColor: Colors.white.withOpacity(AppSize.opacity),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.titleSignin,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacing.h20(),
            _UsernameInput(),
            const Spacing.h20(),
            _PasswordInput(),
            const Spacing.h20(),
            _LoginButton(),
            const Spacing.h8(),
            const Align(
              alignment: Alignment.centerRight,
              child: LinkText(
                page: PAGES.forgotPassword,
                text: AppStrings.forgotPassword,
              ),
            )
          ],
        ),
      );
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return MyTextField(
            Icons.person,
            AppStrings.hintUserName,
            key: AppKeys.loginUsername,
            onChanged: (username) => context.read<LoginBloc>().add(
                  LoginUsernameChanged(username),
                ),
            errorText: state.username.displayError?.text(),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return MyTextField(
            Icons.lock,
            AppStrings.hintPw,
            key: AppKeys.loginPassword,
            onChanged: (password) => context.read<LoginBloc>().add(
                  LoginPasswordChanged(password),
                ),
            obscureText: true,
            errorText: state.password.displayError?.text(),
          );
        });
  }
}

class _RememberMeCheckbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) =>
            previous.rememberMe != current.rememberMe,
        builder: (context, state) {
          return MyCheckbox(
            label: AppStrings.rememberMe,
            isChecked: state.rememberMe,
            onChanged: (newvalue) {
              if (newvalue == null) {
                return;
              }
              context.read<LoginBloc>().add(LoginPersistenceChanged(newvalue));
            },
          );
        });
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : MyButton.primary(
                key: AppKeys.loginSubmit,
                onPressed: state.isValid
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                label: AppStrings.labelLogin,
              );
      },
    );
  }
}
