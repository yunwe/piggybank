import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/auth_repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, void> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(LoginUseCaseInput input) async {
    try {
      await _repository.signIn(
        email: input.email,
        password: input.password,
        isPersist: input.isPersist,
      );
      return const Right(null);
    } on BaseException catch (failure) {
      return Left(failure.toFailure);
    } catch (error) {
      var failure =
          const Failure('Default Error Message'); //Todo: Change String
      return Left(failure);
    }
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  bool isPersist;

  LoginUseCaseInput(this.email, this.password, this.isPersist);
}
