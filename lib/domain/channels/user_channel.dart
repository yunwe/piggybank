import 'dart:async';

import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/repository.dart';

class UserChannel {
  UserChannel({
    required this.repository,
  });

  final Repository repository;

  Stream<User> get user => repository.user;
}
