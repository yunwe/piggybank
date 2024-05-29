import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/domain/usecase/archive_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/delete_wallet_usecase.dart';
import 'package:piggybank/presentation/controller/wallets/wallets_bloc.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/wallet/detail/detail.dart';
import 'package:piggybank/presentation/screens/wallet/detail/view/detail_page_content.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.walletId,
  });

  final String walletId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletsBloc, WalletsState>(
      builder: (context, state) {
        switch (state.status) {
          case WalletsStatus.loading:
            return const FullPageLoading();
          case WalletsStatus.fail:
            return ShowError.error(
              state.failure!,
              label: AppStrings.labelBackToHome,
              onPressed: () {
                AppRouter.router.goNamed(PAGES.walletList.screenName);
              },
            );

          case WalletsStatus.result:
            return BlocProvider(
              create: (context) => WalletDetailBloc(
                archiveUseCase: injector<ArchiveWalletUseCase>(),
                deleteUseCase: injector<DeleteWalletUseCase>(),
              ),
              child: DetialPageContent(
                walletId: walletId,
                wallets: state.wallets,
              ),
            );
        }
      },
    );
  }
}
