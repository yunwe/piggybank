import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piggybank/domain/model/wallet.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';

class FirebaseWalletRepository implements WalletRepository {
  FirebaseWalletRepository({
    FirebaseFirestore? db,
  }) : _db = db ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  static const String _collection = 'wallets';

  @override
  Future<void> create({
    required String userId,
    required String title,
    double? targetAmount,
    DateTime? targetEndDate,
  }) async {
    try {
      _db.collection(_collection).add(
            _doc(
              userId: userId,
              title: title,
              targetAmount: targetAmount,
              targetEndDate: targetEndDate,
            ),
          );
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

  Map<String, dynamic> _doc({
    required String userId,
    required String title,
    double? targetAmount,
    DateTime? targetEndDate,
  }) {
    return <String, dynamic>{
      'user_id': userId,
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
  }
}
