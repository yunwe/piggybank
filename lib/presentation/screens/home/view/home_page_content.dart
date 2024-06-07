import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/route/route.dart';
import 'package:piggybank/app/service/format_string.dart';
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
      backgroundColor: MyColors.khaki,
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
          : Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 45),
                      decoration: BoxDecoration(
                        color: MyColors.primary,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: const Center(child: _TotalSaving(10000000)),
                    ),
                    Positioned(
                      bottom: -30,
                      left: 10,
                      right: 10,
                      child: _Report(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p8),
                    child: Text(
                      'Current Goals',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: MyColors.darkBlue,
                          ),
                    ),
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  itemBuilder: (context, index) => HomePageItem(filteredWallets[index]),
                  itemCount: filteredWallets.length,
                  shrinkWrap: true,
                ),
              ],
            );
    });
  }

  Widget get empty => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text(AppStrings.messageCreateWallet),
          const Spacing.h20(),
          MyButton.khaki(
            onPressed: () {
              AppRouter.router.pushNamed(PAGES.walletNew.screenName);
            },
            label: AppStrings.labelCreate,
          ),
        ]),
      );
}

class _TotalSaving extends StatelessWidget {
  final double amount;

  const _TotalSaving(this.amount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '\$${amount.formatCurrency()}',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: MyColors.hotPink),
        ),
        Text(
          AppStrings.labelTotal,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: MyColors.darkBlue),
        ),
      ],
    );
  }
}

class _Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20, vertical: AppPadding.p8),
      decoration: BoxDecoration(
        color: MyColors.khaki,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: MyColors.khakiD2.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          block(context, 'Goals', '3'),
          block(
            context,
            'This Month',
            '\$${(9000.0).formatCurrency()}',
          ),
          block(context, 'Last Month', '\$${(890.0).formatCurrency()}'),
        ],
      ),
    );
  }

  Widget block(BuildContext context, String label, String vlaue) => Column(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: MyColors.khakiD2,
                ),
          ),
          Text(
            vlaue,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: MyColors.darkBlue,
                ),
          ),
        ],
      );
}
