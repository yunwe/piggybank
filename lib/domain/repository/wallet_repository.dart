import '../model/models.dart';

abstract class WalletRepository {
  //Output

  Stream<List<Wallet>> get wallets;

  //Input Functions
  Future<void> create({
    required String userId,
    required String title,
    double? targetAmount,
    DateTime? targetEndDate,
  });

  Future<Wallet> update({
    required Wallet wallet,
    bool isArchived = false,
    double? amount,
  });

  Future<void> delete({required Wallet wallet});

  Future<void> list(String userId);
}
