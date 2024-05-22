import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';

class SignupUseCase implements BaseUseCase<SignupUseCaseInput, void> {
  final Repository _repository;

  SignupUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(SignupUseCaseInput input) async {
    try {
      await _repository.signUp(email: input.email, password: input.password);
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

class SignupUseCaseInput {
  String email;
  String password;

  SignupUseCaseInput(this.email, this.password);
}
