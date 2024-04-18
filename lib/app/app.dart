import 'package:flutter/material.dart';
import 'package:piggybank/presentation/resources/routes_manager.dart';
import 'package:piggybank/presentation/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  // private named constructor
  const MyApp._internal();

  // single instance -- singleton
  static const MyApp _instance = MyApp._internal();

  // factory for the class instance
  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: getApplicationTheme(),
    );
  }
}
