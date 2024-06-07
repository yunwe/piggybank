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
      backgroundColor: MyColors.khaki,
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

    return BlocBuilder<ArchivePageBloc, ArchivePageState>(
        builder: (context, state) {
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
          const Text(AppStrings.noArchive),
          const Spacing.h20(),
          MyButton.khaki(
            onPressed: () {
              AppRouter.router.goNamed(PAGES.walletList.screenName);
            },
            label: AppStrings.labelBackToHome,
          )
        ]),
      );
}

class _Item extends StatelessWidget {
  final Wallet wallet;

  const _Item(this.wallet);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.khaki,
      child: ListTile(
        leading: noTarget,
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
        ),
        //  trailing: Icon(Icons.satellite),
        onTap: () {
          AppRouter.router.pushNamed(
            PAGES.walletDetail.screenName,
            pathParameters: {"id": wallet.id},
          );
        },
      ),
    );
  }

  Widget get targetDone => leadingIcon(Colors.green, Icons.verified);

  Widget get targetFailed =>
      leadingIcon(Colors.red, Icons.sentiment_very_dissatisfied);

  Widget get noTarget => leadingIcon(MyColors.onWhite, Icons.movie);

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
