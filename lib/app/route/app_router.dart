import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/presentation/controller/app/bloc/app_bloc.dart';
import 'package:piggybank/presentation/screens/error/error.dart';
import 'package:piggybank/presentation/screens/home/home.dart';
import 'package:piggybank/presentation/screens/auth/login/login.dart';
import 'package:piggybank/presentation/screens/auth/register/register.dart';
import 'package:piggybank/presentation/screens/new_wallet/new_wallet.dart';
import 'route_utils.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: PAGES.onboarding.screenPath,
    routes: [
      GoRoute(
          path: PAGES.walletList.screenPath,
          name: PAGES.walletList.screenName,
          builder: (context, state) {
            initListWalletModule();
            return BlocProvider.value(
              value: context.read<AppBloc>(),
              child: const HomePage(),
            );
          }),
      GoRoute(
          path: PAGES.walletNew.screenPath,
          name: PAGES.walletNew.screenName,
          builder: (context, state) {
            initCreateWalletModule();
            return BlocProvider.value(
              value: context.read<AppBloc>(),
              child: const NewWalletPage(),
            );
          }),
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
        path: PAGES.error.screenPath,
        name: PAGES.error.screenName,
        builder: (context, state) => const ErrorPage(),
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
