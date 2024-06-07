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
          ElevatedButton(
            onPressed: () {
              AppRouter.router.pushNamed(PAGES.walletNew.screenName);
            },
            child: const Text(AppStrings.labelCreate),
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
        leading: targetDone,
        title: Text(
          wallet.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: MyColors.darkBlue,
              ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            info(Icons.attach_money, '1,000'),
            info(Icons.calendar_today, 'Dec, 2022'),
          ],
        ), //  trailing: Icon(Icons.satellite),
        onTap: () {
          AppRouter.router.pushNamed(
            PAGES.walletDetail.screenName,
            pathParameters: {"id": wallet.id},
          );
        },
      ),
    );
  }

  Widget get targetDone => leadingIcon(MyColors.khakiPrimary, Icons.verified);

  Widget leadingIcon(Color color, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Icon(
        icon,
        color: color,
        size: AppSize.iconSize,
      ),
    );
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
