import 'package:flutter/material.dart';
import 'package:piggybank/app/route/route.dart';
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
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
