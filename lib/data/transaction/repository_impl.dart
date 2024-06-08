import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piggybank/app/service/network_info.dart';
import 'package:piggybank/data/transaction/mappers.dart';
import 'package:piggybank/domain/model/models.dart' as domain;
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/transaction_repository.dart';

class FirebaseTransactionRepository implements TransactionRepository {
  FirebaseTransactionRepository({
    FirebaseFirestore? db,
    required this.networkInfo,
  }) : _db = db ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;
  final NetworkInfo networkInfo;

  static const String _collection = 'transactions';

  @override
  Future<void> create({required domain.Wallet wallet, required double amount, String? remark}) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw const ConnectionFailure();
    }
    try {
      await _db.collection(_collection).add(TransactionMapper.toDocument(
            walletId: wallet.id,
            amount: amount,
            updatedBalance: wallet.amount + amount,
            remark: remark,
          ));
    } catch (e) {
      if (e is FirebaseException) {
        throw FirestoreFailure(e.message ?? 'Unknown failure occured.');
      } else {
        throw const FirestoreFailure();
      }
    }
  }

  @override
  Future<List<domain.Transaction>> list(String walletId) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw const ConnectionFailure();
    }
    try {
      //Retrieve from firestore
      final snapShot = await _db
          .collection(_collection)
          .where(
            WALLET_ID,
            isEqualTo: walletId,
          )
          .get();

      //Convert to Wallet Objects
      List<domain.Transaction> result = [];
      for (var docSnapshot in snapShot.docs) {
        result.add(TransactionMapper.fromDocument(docSnapshot));
      }

      return result;
    } catch (e) {
      if (e is FirebaseException) {
        throw FirestoreFailure(e.message ?? 'Unknown failure occured.');
      } else {
        throw const FirestoreFailure();
      }
    }
  }

  //TODO: filter owner
  @override
  Future<double> sum(String userId, int month, int year) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw const ConnectionFailure();
    }
    try {
      double startOfMonth = DateTime(year, month).millisecondsSinceEpoch.toDouble();
      double endOfMonth = DateTime(year, month + 1).millisecondsSinceEpoch.toDouble();

      //Retrieve from firestore
      final snapShot = await _db
          .collection(_collection)
          .where(
            CREATED_AT,
            isGreaterThanOrEqualTo: startOfMonth,
          )
          .where(CREATED_AT, isLessThan: endOfMonth)
          .get();

      //Convert to Wallet Objects
      List<domain.Transaction> result = [];
      for (var docSnapshot in snapShot.docs) {
        result.add(TransactionMapper.fromDocument(docSnapshot));
      }

      double sum = 0;
      for (var transaction in result) {
        sum += transaction.amount;
      }

      return sum;
    } catch (e) {
      if (e is FirebaseException) {
        throw FirestoreFailure(e.message ?? 'Unknown failure occured.');
      } else {
        throw const FirestoreFailure();
      }
    }
  }
}
