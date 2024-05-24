import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piggybank/app/service/network_info.dart';
import 'package:piggybank/domain/model/wallet.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';

class FirebaseWalletRepository implements WalletRepository {
  FirebaseWalletRepository({
    FirebaseFirestore? db,
    required this.networkInfo,
  }) : _db = db ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;
  final NetworkInfo networkInfo;

  static const String _collection = 'wallets';

  @override
  Future<void> create({
    required String userId,
    required String title,
    double? targetAmount,
    DateTime? targetEndDate,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw const ConnectionFailure();
    }
    try {
      final ref = await _db.collection(_collection).add(
            _doc(
              userId: userId,
              title: title,
              targetAmount: targetAmount,
              targetEndDate: targetEndDate,
            ),
          );
      print('success');
    } catch (e) {
      if (e is FirebaseException) {
        throw FirestoreFailure(e.message ?? 'Unknown failure occured.');
      } else {
        throw const FirestoreFailure();
      }
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

/// Thrown during the logout process if a failure occurs.
class FirestoreFailure extends BaseException {
  const FirestoreFailure([super.message = 'An unknown exception occurred.']);
}
