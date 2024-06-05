import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/resources.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.darkGrey.withOpacity(0.7),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
