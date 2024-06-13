import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/auth_repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';

class ResetPasswordUseCase
    implements BaseUseCase<ResetPasswordUseCaseInput, void> {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(ResetPasswordUseCaseInput input) async {
    try {
      await _repository.resetPassword(email: input.email);
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

class ResetPasswordUseCaseInput {
  String email;

  ResetPasswordUseCaseInput(this.email);
}
