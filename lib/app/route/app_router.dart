import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/presentation/screens/auth/recover/recover.dart';
import 'package:piggybank/presentation/screens/home/home.dart';
import 'package:piggybank/presentation/screens/auth/login/login.dart';
import 'package:piggybank/presentation/screens/auth/register/register.dart';
import 'package:piggybank/presentation/screens/wallet/archive/archive.dart';
import 'package:piggybank/presentation/screens/wallet/detail/detail.dart';
import 'package:piggybank/presentation/screens/wallet/new_wallet/new_wallet.dart';
import 'route_utils.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: PAGES.signin.screenPath,
    routes: [
      GoRoute(
        path: PAGES.walletList.screenPath,
        name: PAGES.walletList.screenName,
        builder: (context, state) {
          initListWalletModule();
          return const HomePage();
        },
      ),
      GoRoute(
        path: PAGES.walletNew.screenPath,
        name: PAGES.walletNew.screenName,
        builder: (context, state) {
          initCreateWalletModule();
          return const NewWalletPage();
        },
      ),
      GoRoute(
        path: PAGES.walletDetail.screenPath,
        name: PAGES.walletDetail.screenName,
        builder: (context, state) {
          initDetailWalletModule();
          return DetailPage(walletId: state.pathParameters['id'] ?? '-');
        },
      ),
      GoRoute(
        path: PAGES.archivedWalletList.screenPath,
        name: PAGES.archivedWalletList.screenName,
        builder: (context, state) {
          return const ArchivePage();
        },
      ),
      GoRoute(
        path: PAGES.signin.screenPath,
        name: PAGES.signin.screenName,
        builder: (context, state) {
          initLoginModule();
          return const LoginPage();
        },
      ),
      GoRoute(
        path: PAGES.register.screenPath,
        name: PAGES.register.screenName,
        builder: (context, state) {
          initSignupModule();
          return const RegisterPage();
        },
      ),
      GoRoute(
        path: PAGES.forgotPassword.screenPath,
        name: PAGES.forgotPassword.screenName,
        builder: (context, state) {
          initResetPasswordModule();
          return const RecoverView();
        },
      ),
      GoRoute(
        path: PAGES.onboarding.screenPath,
        name: PAGES.onboarding.screenName,
        builder: (context, state) => const _NoPageFound(),
      ),
    ],
    errorBuilder: (context, state) => const _NoPageFound(),
    // redirect: (context, state) async {
    //   print(state.name ?? 'Route page do not have name');
    //   // Here we need to read the context `context.read()` and decide what to do with its new values. we don't want to trigger any new rebuild through `context.watch`
    //   final status = context.read<AppBloc>().state.status;
    //   if (status == AppStatus.authenticated) {
    //     return null;
    //   }
    //   return PAGES.signin.screenPath;
    // },
  );

  static GoRouter get router => _router;
}

class _NoPageFound extends StatelessWidget {
  const _NoPageFound();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Route not found!'),
      ),
    );
  }
}
