import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/domain/usecase/login_usecase.dart';
import 'package:piggybank/presentation/resources/app_strings.dart';
import 'package:piggybank/presentation/resources/colors.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/login/bloc/login_bloc.dart';
import 'package:piggybank/presentation/screens/login/view/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: GradientContainerWidget(
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocProvider(
                create: (context) {
                  return LoginBloc(
                    useCase: injector<LoginUseCase>(),
                  );
                },
                child: const LoginForm(),
              ),
              space,
              const Divider(),
              const LinkText(
                page: PAGES.register,
                text: AppStrings.registerText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get space => const SizedBox(
        height: 40,
      );
}
