import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/presentation/controller/app/bloc/app_bloc.dart';
import 'package:piggybank/presentation/controller/wallets/wallets_bloc.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/wallet/archive/view/archive_page_content.dart';

//Read Controllers bloc and handle Loading, Error, Content State
class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        if (appState.user.isEmpty) {
          return ShowError.noAuth();
        }
        return BlocBuilder<WalletsBloc, WalletsState>(
          builder: (context, walletState) {
            switch (walletState.status) {
              case WalletsStatus.result:
                return ArchivePageContent(wallets: walletState.wallets);
              case WalletsStatus.fail:
                return ShowError.error(
                  walletState.failure!,
                  label: AppStrings.labelRetry,
                  onPressed: () {
                    context.read<WalletsBloc>().add(
                          WalletsRequested(userId: appState.user.id),
                        );
                  },
                );
              case WalletsStatus.loading:
              default:
                return const FullPageLoading();
            }
          },
        );
      },
    );
  }
}
