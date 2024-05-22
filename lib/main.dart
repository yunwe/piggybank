import 'package:flutter/material.dart';
import 'package:piggybank/app/app.dart';
import 'package:piggybank/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const App());
}
