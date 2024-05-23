import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/di.dart';
import 'package:piggybank/domain/usecase/create_wallet_usecase.dart';
import 'package:piggybank/presentation/controller/app/bloc/app_bloc.dart';
import 'package:piggybank/presentation/resources/resources.dart';
import 'package:piggybank/presentation/screens/new_wallet/new_wallet.dart';

class NewWalletPage extends StatelessWidget {
  const NewWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: form(context),
    );
  }

  Widget form(BuildContext context) => BlocBuilder<AppBloc, AppState>(
        builder: (context, state) => state.user.isEmpty
            ? const Text('User is empty')
            : BlocProvider(
                create: (context) => NewWalletBloc(
                  useCase: injector<CreateWalletUseCase>(),
                  userId: state.user.id,
                ),
                child: const NewWalletForm(),
              ),
      );
}
