import '../model/models.dart';

abstract class Repository {
  //Output
  Stream<User> get user;

  //Input Functions
  Future<void> signUp({required String email, required String password});

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();
}
