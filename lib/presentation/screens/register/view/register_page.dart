import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/domain/usecase/signup_usercase.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/register/register.dart';
import 'package:piggybank/presentation/screens/register/view/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocProvider(
              create: (context) => RegisterBloc(
                useCase: injector<SignupUseCase>(),
              ),
              child: const RegisterForm(),
            ),

            //          SharedWidgets.whiteSpace,
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
}
