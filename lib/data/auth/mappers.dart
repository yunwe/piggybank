import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:piggybank/domain/model/models.dart';

extension UserMapper on firebase_auth.User {
  /// Maps a [firebase_auth.User] into a [User].
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
