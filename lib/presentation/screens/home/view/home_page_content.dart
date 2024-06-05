import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/route/route.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import '../bloc/home_page_bloc.dart';
import 'view.dart';

//
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key, required this.wallets});

  final List<Wallet> wallets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomePageAppbar(),
      backgroundColor: MyColors.primary,
      drawer: const HomePageDrawer(),
      body: BlocProvider<HomePageBloc>(
        create: (context) => HomePageBloc(),
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
    context.read<HomePageBloc>().add(HomePageWalletsChanged(wallets));

    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
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
          const Text(AppStrings.messageCreateWallet),
          const Spacing.h20(),
          ElevatedButton(
            onPressed: () {
              AppRouter.router.pushNamed(PAGES.walletNew.screenName);
            },
            child: const Text(AppStrings.labelCreate),
          ),
        ]),
      );
}
