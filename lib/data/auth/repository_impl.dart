import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:piggybank/app/service/network_info.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/auth_repository.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'mappers.dart';
import 'exceptions.dart';

class FirebaseAuthRepository extends AuthRepository {
  FirebaseAuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    required this.networkInfo,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final NetworkInfo networkInfo;

  /// Whether or not the current environment is web
  /// Should only be overridden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  bool isWeb = kIsWeb;

  // Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  @override
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      return user;
    });
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  @override
  Future<void> signUp({required String email, required String password}) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw const ConnectionFailure();
    }

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw const ConnectionFailure();
    }

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  @override
  Future<void> signOut() async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw const ConnectionFailure();
    }

    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw const LogOutFailure();
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw const ConnectionFailure();
    }

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (_) {
      throw const ResetPasswordFailure();
    }
  }
}
