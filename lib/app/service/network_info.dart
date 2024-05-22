import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkInfo {
  final InternetConnection connectionChecker;

  NetworkInfo() : connectionChecker = InternetConnection();

  Future<bool> get isConnected => connectionChecker.hasInternetAccess;
}
