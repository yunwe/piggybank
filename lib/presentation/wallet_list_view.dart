import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piggybank/presentation/resources/routes_manager.dart';

class WalletListView extends StatelessWidget {
  const WalletListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed(RoutesManager.details, pathParameters: {'id': '1'}),
          child: const Text(
            'Go to the Details screen',
          ),
        ),
      ),
    );
  }
}
