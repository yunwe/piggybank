import 'package:flutter/material.dart';

class FullPageLoading extends StatelessWidget {
  const FullPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
