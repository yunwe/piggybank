import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/route/route.dart';
import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/app/service/format_string.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/percentage_icon.dart';
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
              padding: const EdgeInsets.all(AppPadding.p20),
              itemBuilder: (context, index) => _Item(filteredWallets[index]),
              itemCount: filteredWallets.length,
              shrinkWrap: true,
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

class _Item extends StatelessWidget {
  final Wallet wallet;

  const _Item(this.wallet);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: icon(wallet),
        title: Text(
          wallet.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: MyColors.darkBlue,
              ),
        ),
        subtitle: infoRow(wallet),
        onTap: () {
          AppRouter.router.pushNamed(
            PAGES.walletDetail.screenName,
            pathParameters: {"id": wallet.id},
          );
        },
      ),
    );
  }

  Widget icon(Wallet wallet) {
    if (wallet.targetEndDate != null) {
      TargetReport report = TargetReport(wallet: wallet);
      return PercentageIcon(report.amountAchievement);
    }

    return ColorIcon.fromType(ColorIconType.saving);
  }

  Widget infoRow(Wallet wallet) {
    if (wallet.targetEndDate != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          info(Icons.attach_money, wallet.amount.formatCurrency()),
          info(Icons.calendar_today, wallet.targetEndDate!.formatMonth()),
        ],
      );
    }

    return info(Icons.attach_money, wallet.amount.formatCurrency());
  }

  Widget info(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppSize.iconSizeXS,
        ),
        const Spacing.w5(),
        Text(text),
      ],
    );
  }
}
