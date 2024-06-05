import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/app/route/route.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../bloc/wallet_detail_bloc.dart';
import 'active_wallet/view.dart' as active;
import 'archived_wallet/view.dart' as archived;

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.walletId,
  });

  final String walletId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletDetailBloc(
        getWalletUseCase: injector(),
        listTransactionUseCase: injector(),
        archiveUseCase: injector(),
        deleteUseCase: injector(),
      ),
      child: _Page(walletId),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page(this.walletId);

  final String walletId;

  @override
  Widget build(BuildContext context) {
    context.read<WalletDetailBloc>().add(WalletDetailPageInitialzed(walletId: walletId));

    return BlocListener<WalletDetailBloc, WalletDetialState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case DetailPageStatus.pure:
            if (state.message != null) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.message!)),
                );
            }
            break;
          case DetailPageStatus.fail:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.failure!.message)),
              );
            break;
          case DetailPageStatus.deleted:
            AppRouter.router.goNamed(PAGES.walletList.screenName);
            break;
          case DetailPageStatus.targetReached:
            MessageBox.showInformation(context, AppStrings.titleTargetReached, state.message!, () {
              Navigator.pop(context);
              context.read<WalletDetailBloc>().add(const WalletDetailArchiveRequested());
            });
            break;
          default:
            break;
        }
      },
      child: builder,
    );
  }

  Widget get builder => BlocBuilder<WalletDetailBloc, WalletDetialState>(builder: (context, state) {
        if (state.wallet == null) {
          if (state.status == DetailPageStatus.processing) {
            return const FullPageLoading();
          }

          return ShowError.noWallet();
        }

        Wallet wallet = state.wallet!;
        //Check if the wallet's target date has reached
        if (state.status == DetailPageStatus.pure) {
          if (!wallet.isArchived && wallet.isTargetDateReached) {
            context.read<WalletDetailBloc>().add(const WalletDetailTargetDateReached());
          }
        }

        if (wallet.isArchived) {
          return archived.PageContent(
            wallet: wallet,
            transactions: state.transactions,
            isProcessing: state.status == DetailPageStatus.processing,
          );
        } else {
          return active.PageContent(
            wallet: wallet,
            transactions: state.transactions,
            isProcessing: state.status == DetailPageStatus.processing,
          );
        }
      });
}
