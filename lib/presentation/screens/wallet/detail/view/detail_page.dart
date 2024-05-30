import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/domain/usecase/archive_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/delete_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/get_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/list_transaction_usecase.dart';
import 'package:piggybank/presentation/screens/wallet/detail/detail.dart';

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
        getWalletUseCase: injector<GetWalletUseCase>(),
        listTransactionUseCase: injector<ListTransactionUseCase>(),
        archiveUseCase: injector<ArchiveWalletUseCase>(),
        deleteUseCase: injector<DeleteWalletUseCase>(),
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
      child: const DetialPageContent(),
    );
  }
}
