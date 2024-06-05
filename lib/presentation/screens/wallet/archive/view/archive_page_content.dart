import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../bloc/archive_page_bloc.dart';

//
class ArchivePageContent extends StatelessWidget {
  const ArchivePageContent({super.key, required this.wallets});

  final List<Wallet> wallets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.archive),
      ),
      backgroundColor: MyColors.primary,
      //drawer: const HomePageDrawer(),
      body: BlocProvider<ArchivePageBloc>(
        create: (context) => ArchivePageBloc(),
        child: _PageContent(wallets: wallets),
      ),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({required this.wallets});

  final List<Wallet> wallets;

  @override
  Widget build(BuildContext context) {
    context.read<ArchivePageBloc>().add(ArchivePageWalletsChanged(wallets));

    return BlocBuilder<ArchivePageBloc, ArchivePageState>(builder: (context, state) {
      List<Wallet> filteredWallets = state.wallets;

      return filteredWallets.isEmpty
          ? empty
          : ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(filteredWallets[index].title),
                onTap: () {
                  AppRouter.router.pushNamed(
                    PAGES.walletDetail.screenName,
                    pathParameters: {"id": filteredWallets[index].id},
                  );
                },
              ),
              itemCount: filteredWallets.length,
              shrinkWrap: true,
            );
    });
  }

  Widget get empty => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text(AppStrings.noArchive),
          const Spacing.h20(),
          ElevatedButton(
            onPressed: () {
              AppRouter.router.goNamed(PAGES.walletList.screenName);
            },
            child: const Text(AppStrings.labelBackToHome),
          ),
        ]),
      );
}
