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

  Future<void> update();

  Future<void> delete({required String id});

  Future<void> list(String userId);

  Future<Wallet> get({required String id});
}
