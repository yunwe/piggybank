import 'dart:async';

import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/auth_repository.dart';

class UserChannel {
  UserChannel({
    required this.repository,
  });

  final AuthRepository repository;

  Stream<User> get user => repository.user;
}
