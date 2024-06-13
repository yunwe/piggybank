import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/auth/recover/bloc/recover_bloc.dart';
import 'package:piggybank/presentation/screens/auth/recover/view/recover_form.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';

class RecoverView extends StatelessWidget {
  const RecoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocProvider(
              create: (context) => RecoverBloc(
                useCase: injector(),
              ),
              child: const RecoverForm(),
            ),
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
