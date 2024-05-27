import 'package:flutter/material.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/home/view/home_page_appbar.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key, required this.wallets});

  final List<Wallet> wallets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomePageAppbar(),
      backgroundColor: MyColors.primary,
      body: wallets.isNotEmpty ? content : empty,
    );
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

  Widget get content => ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(wallets[index].title),
          onTap: () {
            AppRouter.router.pushNamed(
              PAGES.walletDetail.screenName,
              pathParameters: {"id": wallets[index].id},
            );
          },
        ),
        itemCount: wallets.length,
        shrinkWrap: true,
      );
}
