// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piggybank/data/mixin_dataparser.dart';
import 'package:piggybank/domain/model/models.dart' as domain;

const ID = 'id';
const WALLET_ID = 'wallet_id';
const USER_ID = 'user_id';
const CREATED_AT = 'created_at';
const AMOUNT = 'amount';
const UPDATED_BALANCE = 'updated_balance';
const REMARKS = 'remarks';

class TransactionMapper with DataParser {
  static domain.Transaction fromDocument(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return domain.Transaction(
      id: snapshot.id,
      walletId: data[WALLET_ID],
      userId: data[USER_ID],
      createdTime: DataParser.toDateTime(data[CREATED_AT]),
      amount: DataParser.toDouble(data[AMOUNT]),
      updatedBalance: DataParser.toDouble(data[UPDATED_BALANCE]),
      remarks: data[REMARKS],
    );
  }

  static Map<String, dynamic> toDocument({
    required String walletId,
    required String userId,
    required double amount,
    required double updatedBalance,
    String? remark,
  }) {
    return <String, dynamic>{
      WALLET_ID: walletId,
      USER_ID: userId,
      CREATED_AT: DataParser.currentTimestamp,
      AMOUNT: amount,
      UPDATED_BALANCE: updatedBalance,
      REMARKS: remark
    };
  }
}
