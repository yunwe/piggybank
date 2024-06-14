import 'package:piggybank/domain/model/models.dart';

abstract class AuthRepository {
  //Output
  Stream<User> get user;

  //Input Functions
  Future<void> signUp({required String email, required String password});

  Future<void> signIn({
    required String email,
    required String password,
    required bool isPersist,
  });

  Future<void> signOut();

  Future<void> resetPassword({required String email});
}
