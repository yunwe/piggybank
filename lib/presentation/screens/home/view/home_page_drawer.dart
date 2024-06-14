import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/presentation/controller/app/bloc/app_bloc.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  Widget buildListTile(
      String title, IconData icon, Function() tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        icon,
        size: AppSize.iconSize,
        color: Theme.of(ctx).colorScheme.onBackground,
      ),
      title: Text(
        title,
        style: Theme.of(ctx).textTheme.bodyLarge!.copyWith(
              color: Theme.of(ctx).colorScheme.onBackground,
            ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: AppSize.elevation,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: MyColors.primary,
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.bar_chart,
                  size: AppSize.iconSize,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const Spacing.w15(),
                Text(
                  AppStrings.titleDrawer,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          _DrawerItem(
            label: AppStrings.archive,
            icon: Icons.archive,
            onTap: () {
              Navigator.of(context).pop();
              AppRouter.router.pushNamed(PAGES.archivedWalletList.screenName);
            },
          ),
          _DrawerItem(
            label: AppStrings.labelLogout,
            icon: Icons.logout,
            onTap: () {
              Navigator.of(context).pop();
              context.read<AppBloc>().add(const AppLogoutRequested());
            },
          ),
          // const Divider(),
          // const _DrawerItem(
          //   label: AppStrings.rateUs,
          //   icon: Icons.recommend,
          // ),
          // const _DrawerItem(
          //   label: AppStrings.removeAd,
          //   icon: Icons.remove_circle,
          // ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function()? onTap;

  const _DrawerItem({
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: AppSize.iconSizeS,
      ),
      title: Text(label),
      onTap: onTap,
    );
  }
}
