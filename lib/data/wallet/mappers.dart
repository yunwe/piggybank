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
    print('Converting ${snapshot.id}');

    Map<String, dynamic> data = snapshot.data();
    return Wallet(
      id: snapshot.id,
      title: data[TITLE],
      amount: data[AMOUNT],
      startDate: DateTime(data[CREATED_AT]), //TODO: Fix Here
      // targetAmount: data[TARGET_AMOUNT],
      // targetEndDate: data[TARGET_DATE],
      // isArchived: data[IS_ARCHIVED],
      // archivedDate: data[ARCHIVED_AT],
    );
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
      AMOUNT: 0,
      TARGET_AMOUNT: targetAmount,
      TARGET_DATE: targetEndDate,
      CREATED_AT: DateTime.now().toString(),
      IS_ARCHIVED: false,
      ARCHIVED_AT: null,
      IS_DELETED: false,
      DELETED_AT: null,
    };
  }
}
