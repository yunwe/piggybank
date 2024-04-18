import 'package:flutter/material.dart';

class WalletDetailView extends StatelessWidget {
  const WalletDetailView({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Wallet Detail View - $id'),
      ),
    );
  }
}
