import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';

class WalletsChannel {
  WalletsChannel({
    required this.repository,
  });

  final WalletRepository repository;

  Stream<List<Wallet>> get wallets => repository.wallets;
}
