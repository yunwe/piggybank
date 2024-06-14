import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../bloc/recover_bloc.dart';
import 'recover_form.dart';

class RecoverView extends StatelessWidget {
  const RecoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecoverBloc(
        useCase: injector(),
      ),
      child: const _Page(),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page();

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
        child: Scaffold(
          backgroundColor: MyColors.primary,
          body:
              BlocBuilder<RecoverBloc, RecoverState>(builder: (context, state) {
            if (state.status.isSuccess) {
              return mailSent(context);
            }

            return const RecoverForm();
          }),
        ));
  }

  Widget mailSent(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.titleMailSent,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                AppStrings.textMailSent,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacing.h20(),
              MyButton.primary(
                key: AppKeys.registerSubmit,
                label: AppStrings.labelLogin,
              ),
            ],
          ),
        ),
      );
}
