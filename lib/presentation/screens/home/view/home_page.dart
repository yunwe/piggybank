import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:piggybank/app/route/route_utils.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/controller/app/bloc/app_bloc.dart';
import 'package:piggybank/presentation/controller/wallets/wallets_bloc.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';

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
      body: BlocBuilder<WalletsBloc, WalletsState>(
        builder: (context, state) {
          switch (state.status) {
            case WalletsStatus.result:
              return walletList(state.wallets);
            case WalletsStatus.fail:
              return buildError(state.failure!);
            case WalletsStatus.loading:
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Text(state.user.email ?? '-'),

      //     ElevatedButton(
      //       onPressed: () {
      //         GoRouter.of(context).push(PAGES.walletNew.screenPath);
      //       },
      //       child: const Text(AppStrings.titleCreate),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         ListWalletUseCaseInput input = ListWalletUseCaseInput(state.user.id);
      //         injector<ListWalletUseCase>().execute(input);
      //       },
      //       child: const Text('Get List'),
      //     ),
      //   ],
      // ),
    );
  }

  Widget walletList(List<Wallet> wallets) => ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(wallets[index].title),
          onTap: () {
            GoRouter.of(context).pushNamed(
              PAGES.walletDetail.screenName,
              extra: wallets[index],
            );
          },
        ),
        itemCount: wallets.length,
        shrinkWrap: true,
      );

  Widget buildError(Failure failure) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if (state.user.isEmpty) {
        return ShowError(
          failure: const Failure(AppStrings.textNoAuth),
          label: AppStrings.labelLogin,
          onPressed: () {
            context.goNamed(PAGES.signin.screenName);
          },
        );
      }
      return ShowError(
        failure: failure,
        label: AppStrings.labelRetry,
        onPressed: () {
          context.read<WalletsBloc>().add(
                WalletListRequested(userId: state.user.id),
              );
        },
      );
    });
  }
}
