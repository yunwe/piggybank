import '../model/models.dart';

abstract class TransactionRepository {
  //Input Functions
  Future<void> create({
    required Wallet wallet,
    required double amount,
    String? remark,
  });

  Future<List<Transaction>> list(String walletId);
}
