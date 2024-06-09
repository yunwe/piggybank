import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/route/route.dart';
import 'package:piggybank/app/service/format_string.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/controller/monthly_saving/monthly_saving_bloc.dart';
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
      if (state.status == HomePageStatus.processing) {
        return const Center(child: CircularProgressIndicator());
      }

      return filteredWallets.isEmpty
          ? empty
          : Column(
              children: [
                _Header(
                  totalAmount: state.totalAmount,
                  walletCount: state.walletCount,
                ),
                const SizedBox(
                  height: 60,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p8),
                    child: Text(
                      AppStrings.titleCurrent,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: MyColors.darkBlue,
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    itemBuilder: (context, index) => HomePageItem(filteredWallets[index]),
                    itemCount: filteredWallets.length,
                  ),
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

class _Header extends StatelessWidget {
  const _Header({
    required this.walletCount,
    required this.totalAmount,
  });

  static const double _corner = 10;
  final int walletCount;
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 45),
          decoration: BoxDecoration(
            color: MyColors.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(_corner),
              bottomRight: Radius.circular(_corner),
            ),
          ),
          child: Center(child: _totalSaving(context, totalAmount)),
        ),
        Positioned(
          bottom: -30,
          left: _corner,
          right: _corner,
          child: _report(context),
        ),
      ],
    );
  }

  Widget _totalSaving(BuildContext context, double amount) {
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

  Widget _report(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20, vertical: AppPadding.p8),
      decoration: BoxDecoration(
        color: MyColors.khaki,
        borderRadius: const BorderRadius.all(
          Radius.circular(_corner),
        ),
        boxShadow: [
          BoxShadow(
            color: MyColors.khakiD2.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                AppStrings.labelGoals,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyColors.khakiD2,
                    ),
              ),
              Text(
                walletCount.toString(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: MyColors.darkBlue,
                    ),
              ),
            ],
          ),
          const _TotalSavedForThisMonth(),
          const _TotalSavedForLastMonth(),
        ],
      ),
    );
  }
}

class _TotalSavedForThisMonth extends StatelessWidget {
  const _TotalSavedForThisMonth();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonthlySavingBloc, MonthlySavingState>(
      buildWhen: (previous, current) => previous.thisMonth != current.thisMonth,
      builder: (context, state) {
        String displayText = '-';
        Color color = MyColors.darkBlue;
        if (state.thisMonth != null) {
          if (state.thisMonth! < 0) {
            displayText = '-\$${state.thisMonth!.abs().formatCurrency()}';
            color = Colors.red;
          } else {
            displayText = '\$${state.thisMonth!.formatCurrency()}';
          }
        }

        return Column(
          children: [
            Text(
              AppStrings.labelThisMonth,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.khakiD2,
                  ),
            ),
            Text(
              displayText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: color,
                  ),
            ),
          ],
        );
      },
    );
  }
}

class _TotalSavedForLastMonth extends StatelessWidget {
  const _TotalSavedForLastMonth();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonthlySavingBloc, MonthlySavingState>(
      buildWhen: (previous, current) => previous.lastMonth != current.lastMonth,
      builder: (context, state) {
        String displayText = '...';
        Color color = MyColors.darkBlue;
        if (state.lastMonth != null) {
          if (state.lastMonth! < 0) {
            displayText = '-\$${state.lastMonth!.abs().formatCurrency()}';
            color = Colors.red;
          } else {
            displayText = '\$${state.lastMonth!.formatCurrency()}';
          }
        }
        return Column(
          children: [
            Text(
              AppStrings.labelLastMonth,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.khakiD2,
                  ),
            ),
            Text(
              displayText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: color,
                  ),
            ),
          ],
        );
      },
    );
  }
}
