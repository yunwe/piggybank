import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/route/app_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/presentation/controller/app/bloc/app_bloc.dart';
import 'package:piggybank/presentation/resources/resources.dart';

class HomePageAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.titleHome),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            AppRouter.router.pushNamed(PAGES.walletNew.screenName);
          },
        ),
        IconButton(
          key: AppKeys.logoutButton,
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            context.read<AppBloc>().add(const AppLogoutRequested());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
