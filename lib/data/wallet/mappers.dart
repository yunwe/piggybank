// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:piggybank/domain/model/models.dart';

const USER_ID = 'user_id';
const TITLE = 'title';
const AMOUNT = 'amount';
const TARGET_AMOUNT = 'target_amount';
const TARGET_DATE = 'target_date';
const CREATED_AT = 'created_at';
const IS_ARCHIVED = 'is_archived';
const ARCHIVED_AT = 'archived_at';
const IS_DELETED = 'is_deleted';
const DELETED_AT = 'deleted_at';

class WalletMapper {
  /// Maps a [firebase_auth.User] into a [User].
  static Wallet fromDocument(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data();

    return Wallet(
      id: snapshot.id,
      ownerId: data[USER_ID],
      title: data[TITLE],
      amount: _toDouble(data[AMOUNT]),
      startDate: _toDateTime(data[CREATED_AT]),
      targetAmount: _toDouble(data[TARGET_AMOUNT]),
      targetEndDate: _toNullableDateTime(data[TARGET_DATE]),
      isArchived: data[IS_ARCHIVED],
      archivedDate: _toNullableDateTime(data[ARCHIVED_AT]),
    );
  }

  static double _toDouble(dynamic value) {
    return double.tryParse(value.toString()) ?? 0;
  }

  static DateTime _toDateTime(dynamic value) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }

  static DateTime? _toNullableDateTime(dynamic? value) {
    if (value == null) {
      return null;
    }

    return _toDateTime(value!);
  }

  static Map<String, dynamic> toDocument({
    required String userId,
    required String title,
    double? targetAmount,
    DateTime? targetEndDate,
  }) {
    return <String, dynamic>{
      USER_ID: userId,
      TITLE: title,
      AMOUNT: 0.0,
      TARGET_AMOUNT: targetAmount,
      TARGET_DATE: targetEndDate?.millisecondsSinceEpoch,
      CREATED_AT: DateTime.now().millisecondsSinceEpoch,
      IS_ARCHIVED: false,
      ARCHIVED_AT: null,
      IS_DELETED: false,
      DELETED_AT: null,
    };
  }
}
