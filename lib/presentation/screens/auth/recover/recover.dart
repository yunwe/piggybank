import 'package:flutter/material.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            formContent(context),
            const Divider(),
            const LinkText(
              page: PAGES.signin,
              text: AppStrings.signinText,
            ),
          ],
        ),
      ),
    );
  }

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
              //   SharedWidgets.getTextFormField(Icons.person, AppStrings.hintEmail),
              //   SharedWidgets.getButton(onPressed: () {}, label: AppStrings.labelReset),
            ],
          ),
        ),
      );

  //   Widget formContent(BuildContext context) => FormContainerWidget(
  //   backgroundColor: Colors.white.withOpacity(AppSize.opacity),
  //   content: SizedBox(
  //     width: AppSize.formEntityWidth,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(
  //           AppStrings.titleRegister,
  //           style: Theme.of(context).textTheme.titleLarge,
  //         ),
  //         const Spacing.h20(),
  //         _UsernameInput(),
  //         const Spacing.h20(),
  //         _PasswordInput(),
  //         const Spacing.h20(),
  //         _ConfirmPasswordInput(),
  //         const Spacing.h8(),
  //         _RegisterButton(),
  //       ],
  //     ),
  //   ),
  // );
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<RegisterBloc, RegisterState>(
    //     buildWhen: (previous, current) => previous.username != current.username,
    //     builder: (context, state) {
    //       return MyTextField(
    //         Icons.person,
    //         AppStrings.hintUserName,
    //         key: AppKeys.registerUsername,
    //         onChanged: (username) => context.read<RegisterBloc>().add(
    //               RegisterUsernameChanged(username),
    //             ),
    //         errorText: state.username.displayError?.text(),
    //       );
    //     });

    return MyTextField(Icons.person, AppStrings.hintUserName);
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<RegisterBloc, RegisterState>(
    //   builder: (context, state) {
    //     return state.status.isInProgress
    //         ? const CircularProgressIndicator()
    //         : MyButton.primary(
    //             key: AppKeys.registerSubmit,
    //             onPressed: state.isValid
    //                 ? () {
    //                     context.read<RegisterBloc>().add(
    //                           const RegisterSubmitted(),
    //                         );
    //                   }
    //                 : null,
    //             label: AppStrings.labelSignup,
    //           );
    //   },
    // );

    return MyButton.primary(
      key: AppKeys.registerSubmit,
      onPressed: null,
      label: AppStrings.labelReset,
    );
  }
}
