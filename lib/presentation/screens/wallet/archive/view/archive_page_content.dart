import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/app/service/format_string.dart';
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

    return BlocBuilder<ArchivePageBloc, ArchivePageState>(builder: (context, state) {
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
        leading: icon(wallet),
        title: Text(
          wallet.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: MyColors.darkBlue,
              ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            info(Icons.attach_money, wallet.amount.formatCurrency()),
            info(Icons.calendar_today, wallet.archivedDate!.formatMonth()),
          ],
        ),
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
    if (wallet.targetEndDate == null) {
      return const ColorIcon(iconType: IconType.saving);
    } else {
      return wallet.isTargetAmountReached ? const ColorIcon(iconType: IconType.success) : const ColorIcon(iconType: IconType.failed);
    }
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
