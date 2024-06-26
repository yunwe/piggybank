// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:piggybank/data/mixin_dataparser.dart';
import 'package:piggybank/domain/model/models.dart';

const USER_ID = 'user_id';
const TITLE = 'title';
const ICON = 'icon';
const AMOUNT = 'amount';
const TARGET_AMOUNT = 'target_amount';
const TARGET_DATE = 'target_date';
const CREATED_AT = 'created_at';
const IS_ARCHIVED = 'is_archived';
const ARCHIVED_AT = 'archived_at';
const IS_DELETED = 'is_deleted';
const DELETED_AT = 'deleted_at';

class WalletMapper with DataParser {
  /// Maps a [firebase_auth.User] into a [User].
  static Wallet fromDocument(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data();

    return Wallet(
      id: snapshot.id,
      ownerId: data[USER_ID],
      title: data[TITLE],
      icon: data[ICON],
      amount: DataParser.toDouble(data[AMOUNT]),
      startDate: DataParser.toDateTime(data[CREATED_AT]),
      targetAmount: DataParser.toDouble(data[TARGET_AMOUNT]),
      targetEndDate: DataParser.toNullableDateTime(data[TARGET_DATE]),
      isArchived: data[IS_ARCHIVED],
      archivedDate: DataParser.toNullableDateTime(data[ARCHIVED_AT]),
    );
  }

  static Map<String, dynamic> toDocument({
    required String userId,
    required String title,
    required int icon,
    double? targetAmount,
    DateTime? targetEndDate,
  }) {
    return <String, dynamic>{
      USER_ID: userId,
      TITLE: title,
      ICON: icon,
      AMOUNT: 0.0,
      TARGET_AMOUNT: targetAmount,
      TARGET_DATE: targetEndDate?.millisecondsSinceEpoch,
      CREATED_AT: DataParser.currentTimestamp,
      IS_ARCHIVED: false,
      ARCHIVED_AT: null,
      IS_DELETED: false,
      DELETED_AT: null,
    };
  }
}
