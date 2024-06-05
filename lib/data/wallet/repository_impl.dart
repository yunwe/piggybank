import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piggybank/app/service/network_info.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';
import 'mappers.dart';

class FirebaseWalletRepository implements WalletRepository {
  FirebaseWalletRepository({
    FirebaseFirestore? db,
    required this.networkInfo,
  }) : _db = db ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;
  final NetworkInfo networkInfo;

  static const String _collection = 'wallets';
  @override
  Stream<List<Wallet>> get wallets => _streamController.stream;

  final StreamController<List<Wallet>> _streamController = StreamController<List<Wallet>>();
  List<Wallet> _cache = [];

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
      await _db.collection(_collection).add(
            WalletMapper.toDocument(
              userId: userId,
              title: title,
              targetAmount: targetAmount,
              targetEndDate: targetEndDate,
            ),
          );
    } catch (e) {
      if (e is FirebaseException) {
        throw FirestoreFailure(e.message ?? 'Unknown failure occured.');
      } else {
        throw const FirestoreFailure();
      }
    }
  }

  @override
  Future<Wallet> update({
    required Wallet wallet,
    bool isArchived = false,
    double? amount,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw const ConnectionFailure();
    }
    try {
      Map<String, dynamic> query = {};

      DateTime? archivedAt;
      if (isArchived) {
        archivedAt = DateTime.now();
        query[IS_ARCHIVED] = true;
        query[ARCHIVED_AT] = archivedAt.millisecondsSinceEpoch;
      }

      if (amount != null) {
        query[AMOUNT] = amount;
      }

      await _db.collection(_collection).doc(wallet.id).update(query);

      return wallet.copyWith(
        isArchived: isArchived,
        archivedDate: archivedAt,
        amount: amount,
      );
    } catch (e) {
      if (e is FirebaseException) {
        throw FirestoreFailure(e.message ?? 'Unknown failure occured.');
      } else {
        throw const FirestoreFailure();
      }
    }
  }

  @override
  Future<void> delete({required Wallet wallet}) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw const ConnectionFailure();
    }
    try {
      Map<String, dynamic> query = {
        IS_DELETED: true,
        DELETED_AT: DateTime.now().millisecondsSinceEpoch,
      };

      await _db.collection(_collection).doc(wallet.id).update(query);
      await list(wallet.ownerId);
    } catch (e) {
      if (e is FirebaseException) {
        throw FirestoreFailure(e.message ?? 'Unknown failure occured.');
      } else {
        throw const FirestoreFailure();
      }
    }
  }

  @override
  Future<void> list(String userId) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw const ConnectionFailure();
    }
    try {
      //Retrieve from firestore
      final snapShot = await _db
          .collection(_collection)
          .where(
            USER_ID,
            isEqualTo: userId,
          )
          .where(
            IS_DELETED,
            isEqualTo: false,
          )
          .get();

      //Convert to Wallet Objects
      List<Wallet> result = [];
      for (var docSnapshot in snapShot.docs) {
        result.add(WalletMapper.fromDocument(docSnapshot));
      }
      //Add to stream
      _streamController.sink.add(result);
      //Save in cache
      _cache = result;
    } catch (e) {
      if (e is FirebaseException) {
        throw FirestoreFailure(e.message ?? 'Unknown failure occured.');
      } else {
        throw const FirestoreFailure();
      }
    }
  }

  @override
  Wallet? getFromCache(String walletId) {
    for (final wallet in _cache) {
      if (wallet.id == walletId) {
        return wallet;
      }
    }

    return null;
  }
}
