import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piggybank/domain/model/wallet.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';

class FirebaseWalletRepository implements WalletRepository {
  FirebaseWalletRepository({
    FirebaseFirestore? db,
  }) : _db = db ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  String collectionPath(String userId) => 'wallets';

  @override
  Future<void> create({
    required String userId,
    required String title,
    double? targetAmount,
    DateTime? targetEndDate,
  }) async {
    final wallet = <String, dynamic>{
      'title': title,
      'amount': 0,
      'target_amount': targetAmount,
      'target_date': targetEndDate,
      'created_at': DateTime.now().toString(),
      'is_archived': false,
      'archived_at': null,
      'is_deleted': false,
      'deleted_at': null,
    };

    try {
      _db.collection(collectionPath(userId)).add(wallet);
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Wallet> get({required String id}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<Wallet>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<void> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
