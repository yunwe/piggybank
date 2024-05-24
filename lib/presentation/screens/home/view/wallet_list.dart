import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/presentation/screens/home/bloc/home_bloc.dart';

class WalletList extends StatelessWidget {
  const WalletList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
      if (state.status == HomePageStatus.loading) {
        return const CircularProgressIndicator();
      }
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(state.wallets[index].title),
        ),
        itemCount: state.wallets.length,
        shrinkWrap: true,
      );
    });
  }
}
