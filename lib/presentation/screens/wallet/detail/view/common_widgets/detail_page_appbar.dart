import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../../bloc/wallet_detail_bloc.dart';

class DetailPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DetailPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletDetailBloc, WalletDetialState>(
      buildWhen: (previous, current) =>
          previous.status != current.status && current.wallet != null,
      builder: (context, state) => AppBar(
        title: Text(
          state.wallet!.title,
        ),
        actions: [
          state.status == DetailPageStatus.processing
              ? const IconButton(
                  onPressed: null, icon: CircularProgressIndicator())
              : MenuAnchor(
                  builder: (BuildContext context, MenuController controller,
                      Widget? child) {
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
                    if (!state.wallet!.isArchived) _archiveMenuButton(context),
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
          MessageBox.showConfirmation(
            context,
            AppStrings.titleConfirmArchive,
            AppStrings.contentConfirmArchive,
            () {
              context
                  .read<WalletDetailBloc>()
                  .add(const WalletDetailArchiveRequested());
              Navigator.of(context).pop();
            },
          );
        },
        leadingIcon: const Icon(Icons.archive),
        child: const Text(AppStrings.labelArchive),
      );

  Widget _deleteMenuButton(BuildContext context) => MenuItemButton(
        onPressed: () {
          MessageBox.showConfirmation(
            context,
            AppStrings.titleConfirmDelete,
            AppStrings.contentConfirmDelete,
            () {
              context
                  .read<WalletDetailBloc>()
                  .add(const WalletDetailDeleteRequested());
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
