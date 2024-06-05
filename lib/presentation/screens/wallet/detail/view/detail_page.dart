import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/app/route/route.dart';
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
      child: BlocBuilder<WalletDetailBloc, WalletDetialState>(
        builder: (context, state) {
          if (state.wallet == null) {
            if (state.status == DetailPageStatus.processing) {
              return const FullPageLoading();
            }

            return ShowError.noWallet();
          }

          if (state.wallet!.isArchived) {
            return archived.PageContent(wallet: state.wallet!, transactions: state.transactions);
          } else {
            return active.PageContent(wallet: state.wallet!, transactions: state.transactions);
          }
        },
      ),
    );
  }
}
