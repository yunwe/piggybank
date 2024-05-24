import '../model/models.dart';

abstract class WalletRepository {
  //Input Functions
  Future<void> create({
    required String userId,
    required String title,
    double? targetAmount,
    DateTime? targetEndDate,
  });

  Future<void> update();

  Future<void> delete({required String id});

  Future<List<Wallet>> list(String userId);

  Future<Wallet> get({required String id});
}
