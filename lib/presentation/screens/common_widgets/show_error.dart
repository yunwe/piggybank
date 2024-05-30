import 'package:flutter/material.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';

class ShowError extends StatelessWidget {
  const ShowError._({
    required this.failure,
    required this.label,
    required this.onPressed,
  });

  ShowError.noAuth()
      : this._(
          failure: const Failure(AppStrings.textNoAuth),
          label: AppStrings.labelLogin,
          onPressed: () {
            AppRouter.router.goNamed(PAGES.signin.screenName);
          },
        );

  ShowError.noWallet()
      : this._(
          failure: const Failure(AppStrings.noWallet),
          label: AppStrings.labelBackToHome,
          onPressed: () {
            AppRouter.router.goNamed(PAGES.walletList.screenName);
          },
        );

  const ShowError.error(Failure failure, {required label, required onPressed})
      : this._(
          failure: failure,
          label: label,
          onPressed: onPressed,
        );

  final Failure failure;
  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        title: const Text(AppStrings.titleError),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(failure.message),
              const Spacing.h20(),
              ElevatedButton(
                onPressed: onPressed,
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
