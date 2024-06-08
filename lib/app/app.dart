import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/app/route/route.dart';
import 'package:piggybank/domain/channels/user_channel.dart';
import 'package:piggybank/domain/channels/wallets_channel.dart';
import 'package:piggybank/domain/usecase/list_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/logout_usecase.dart';
import 'package:piggybank/domain/usecase/sum_transaction_usecase.dart';
import 'package:piggybank/presentation/controller/app/bloc/app_bloc.dart';
import 'package:piggybank/presentation/controller/monthly_saving/monthly_saving_bloc.dart';
import 'package:piggybank/presentation/controller/wallets/wallets_bloc.dart';
import 'package:piggybank/presentation/resources/resources.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(
            userChannel: injector<UserChannel>(),
            logoutUseCase: injector<LogoutUseCase>(),
          ),
        ),
        BlocProvider<WalletsBloc>(
          create: (context) => WalletsBloc(
            walletsChannel: injector<WalletsChannel>(),
            listWalletUseCase: injector<ListWalletUseCase>(),
          ),
        ),
        BlocProvider<MonthlySavingBloc>(
          create: (context) => MonthlySavingBloc(
            sumTransactionUseCase: injector<SumTransactionUseCase>(),
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: getApplicationTheme(),
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            switch (state.status) {
              case AppStatus.authenticated:
                AppRouter.router.goNamed(PAGES.walletList.screenName);
              case AppStatus.unauthenticated:
              default:
                AppRouter.router.goNamed(PAGES.signin.screenName);
            }
          },
          child: child,
        );
      },
    );
  }
}
