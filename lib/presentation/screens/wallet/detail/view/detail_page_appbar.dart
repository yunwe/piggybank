import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/wallet/detail/detail.dart';

class DetailPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DetailPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletDetailBloc, WalletDetialState>(
      buildWhen: (previous, current) => previous.status != current.status,
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
          state.status == DetailPageStatus.processing
              ? const IconButton(onPressed: null, icon: CircularProgressIndicator())
              : MenuAnchor(
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