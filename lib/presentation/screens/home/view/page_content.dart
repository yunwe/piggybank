import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/domain/model/failure.dart';
import 'package:piggybank/domain/model/wallet.dart';
import 'package:piggybank/presentation/resources/resources.dart';

import 'package:piggybank/presentation/screens/common_widgets/widgets.dart';
import 'package:piggybank/presentation/screens/home/bloc/home_bloc.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
      switch (state.status) {
        case HomePageStatus.result:
          return walletList(state.wallets);
        case HomePageStatus.fail:
          return showError(state.failure!, () {
            context.read<HomePageBloc>().add(const WalletListRequested());
          });
        case HomePageStatus.loading:
        default:
          return const CircularProgressIndicator();
      }
    });
  }

  Widget walletList(List<Wallet> wallets) => ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(wallets[index].title),
        ),
        itemCount: wallets.length,
        shrinkWrap: true,
      );

  Widget showError(Failure failure, void Function() retry) => Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(failure.message),
            const Spacing.h20(),
            ElevatedButton(
              onPressed: retry,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
}
