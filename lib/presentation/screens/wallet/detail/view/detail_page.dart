import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/domain/usecase/archive_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/delete_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/get_wallet_usecase.dart';
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
        archiveUseCase: injector<ArchiveWalletUseCase>(),
        deleteUseCase: injector<DeleteWalletUseCase>(),
      ),
      child: DetialPageContent(walletId: walletId),
    );
  }
}
