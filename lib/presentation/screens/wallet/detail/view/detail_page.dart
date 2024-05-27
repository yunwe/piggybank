import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/archive_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/delete_wallet_usecase.dart';
import 'package:piggybank/presentation/controller/wallets/wallets_bloc.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/wallet/detail/detail.dart';

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
        if (state.status == WalletsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        Wallet? wallet;
        for (final data in state.wallets) {
          if (data.id == walletId) {
            wallet = data;
            break;
          }
        }
        if (wallet == null) {
          return ShowError(
            failure: const Failure('No Wallet Found.'),
            label: 'Back to Home',
            onPressed: () {
              context.goNamed(PAGES.walletList.screenName);
            },
          );
        }

        return BlocProvider(
          create: (context) => WalletDetailBloc(
            wallet: wallet!,
            archiveUseCase: injector<ArchiveWalletUseCase>(),
            deleteUseCase: injector<DeleteWalletUseCase>(),
          ),
          child: Scaffold(
            backgroundColor: MyColors.primary,
            appBar: _Appbar(),
            body: const Padding(
              padding: EdgeInsets.all(AppPadding.p20),
              child: _Content(),
            ),
          ),
        );
      },
    );
  }
}

class _Appbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletDetailBloc, WalletDetialState>(
      buildWhen: (previous, current) => previous.wallet != current.wallet,
      builder: (context, state) => AppBar(
        title: Text(
          state.wallet.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        centerTitle: true,
        // iconTheme: const IconThemeData(color: Colors.black),
        // actionsIconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        actions: [
          MenuAnchor(
            builder: (BuildContext context, MenuController controller, Widget? child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(Icons.more_vert),
              );
            },
            menuChildren: [
              if (!state.wallet.isArchived) _archiveMenuButton(context),
              _deleteMenuButton(context),
            ],
          ),
        ],
        scrolledUnderElevation: 0.0,
      ),
    );
  }

  Widget _archiveMenuButton(BuildContext context) => MenuItemButton(
        onPressed: () {
          _showConfirmation(
            context,
            AppStrings.titleConfirmArchive,
            AppStrings.contentConfirmArchive,
            () {
              context.read<WalletDetailBloc>().add(const WalletDetailArchiveRequested());
              Navigator.of(context).pop();
            },
          );
        },
        leadingIcon: const Icon(Icons.archive),
        child: const Text(AppStrings.labelArchive),
      );

  Widget _deleteMenuButton(BuildContext context) => MenuItemButton(
        onPressed: () {
          _showConfirmation(
            context,
            AppStrings.titleConfirmDelete,
            AppStrings.contentConfirmDelete,
            () {
              context.read<WalletDetailBloc>().add(const WalletDetailDeleteRequested());
              Navigator.of(context).pop();
            },
          );
        },
        leadingIcon: const Icon(Icons.delete_forever),
        child: const Text(AppStrings.labelDelete),
      );

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletDetailBloc, WalletDetialState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        switch (state.status) {
          case DetailPageStatus.processing:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Text(state.wallet.title);
        }
      },
    );
  }
}

Future<void> _showConfirmation(BuildContext context, String title, String content, void Function() onProceed) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        title: Text(title),
        titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
              fontWeight: FontWeight.bold,
            ),
        content: Text(content),
        contentTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: onProceed,
            child: const Text('Proceed'),
          ),
        ],
      );
    },
  );
}
