import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/wallet/detail/detail.dart';
import 'package:piggybank/presentation/screens/wallet/detail/view/detail_page_appbar.dart';

class DetialPageContent extends StatelessWidget {
  const DetialPageContent({super.key, required this.walletId});

  final String walletId;

  @override
  Widget build(BuildContext context) {
    context.read<WalletDetailBloc>().add(WalletDetailPageInitialzed(walletId: walletId));

    return BlocListener<WalletDetailBloc, WalletDetialState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == DetailPageStatus.fail) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.failure!.message)),
            );
        }
        if (state.message != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
        }
        if (state.status == DetailPageStatus.deleted) {
          AppRouter.router.goNamed(PAGES.walletList.screenName);
        }
      },
      child: const _PageContent(),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletDetailBloc, WalletDetialState>(builder: (context, state) {
      if (state.wallet == null) {
        if (state.status == DetailPageStatus.processing) {
          return const FullPageLoading();
        }

        return ShowError.error(
          const Failure(AppStrings.noWallet),
          label: AppStrings.labelBackToHome,
          onPressed: () {
            AppRouter.router.goNamed(PAGES.walletList.screenName);
          },
        );
      }

      return content(state.wallet!);
    });
  }

  Widget content(Wallet wallet) => Scaffold(
        backgroundColor: MyColors.primary,
        appBar: const DetailPageAppbar(),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Text(wallet.title),
        ),
        floatingActionButton: wallet.isArchived
            ? null
            : FloatingActionButton(
                onPressed: () {
                  AppRouter.router.pushNamed(
                    PAGES.walletTransaction.screenName,
                    pathParameters: {'wallet': wallet.id},
                    extra: wallet.title,
                  );
                },
                // foregroundColor: Theme.of(context).colorScheme.onPrimary,
                // backgroundColor: Theme.of(context).colorScheme.primary,
                shape: const CircleBorder(),
                child: const Icon(Icons.add),
              ),
      );
}
