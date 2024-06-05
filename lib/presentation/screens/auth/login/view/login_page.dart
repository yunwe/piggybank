import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/app/route/route.dart';
import 'package:piggybank/domain/usecase/login_usecase.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../bloc/login_bloc.dart';
import 'view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Center(
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
    );
  }

  Widget get space => const SizedBox(
        height: 40,
      );
}
