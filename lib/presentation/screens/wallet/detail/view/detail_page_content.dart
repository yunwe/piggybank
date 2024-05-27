import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/app/service/format_string.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/spacing.dart';
import 'package:piggybank/presentation/screens/wallet/detail/detail.dart';
import 'package:piggybank/presentation/screens/wallet/detail/view/detail_page_appbar.dart';

class DetialPageContent extends StatelessWidget {
  const DetialPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: const DetailPageAppbar(),
      body: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: BlocBuilder<WalletDetailBloc, WalletDetialState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              switch (state.status) {
                case DetailPageStatus.processing:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case DetailPageStatus.fail:
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text(state.failure!.message)),
                    );
                  return content(state.wallet);
                case DetailPageStatus.pure:
                  return content(state.wallet);
                case DetailPageStatus.deleted:
                  return deleted(state.wallet);
              }
            },
          )),
    );
  }

  Widget content(Wallet wallet) => Text(wallet.title);

  Widget deleted(Wallet wallet) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppStrings.messageWalletDeleted.format([wallet.title])),
            const Spacing.h20(),
            ElevatedButton(
              onPressed: () {
                AppRouter.router.goNamed(PAGES.walletList.screenName);
              },
              child: const Text(AppStrings.labelBackToHome),
            ),
          ],
        ),
      );
}
