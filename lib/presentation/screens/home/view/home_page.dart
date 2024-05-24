import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/domain/usecase/list_wallet_usecase.dart';
import 'package:piggybank/presentation/controller/app/bloc/app_bloc.dart';
import 'package:piggybank/presentation/resources/resources.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        title: const Text(AppStrings.titleHome),
        actions: <Widget>[
          IconButton(
            key: AppKeys.logoutButton,
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AppBloc>().add(const AppLogoutRequested());
            },
          ),
        ],
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) => state.user.isEmpty
            ? Container()
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.user.email ?? '-'),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).push(PAGES.walletNew.screenPath);
                      },
                      child: const Text(AppStrings.titleCreate),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ListWalletUseCaseInput input = ListWalletUseCaseInput(state.user.id);
                        injector<ListWalletUseCase>().execute(input);
                      },
                      child: const Text('Get List'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
