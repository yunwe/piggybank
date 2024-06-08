import 'package:either_dart/either.dart';
import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/transaction_repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';

class SumTransactionUseCase implements BaseUseCase<SumTransactionUseCaseInput, void> {
  final TransactionRepository _repository;

  SumTransactionUseCase(this._repository);

  @override
  Future<Either<Failure, double>> execute(SumTransactionUseCaseInput input) async {
    try {
      final sum = await _repository.sum(input.userId, input.month, input.year);
      return Right(sum);
    } on BaseException catch (failure) {
      return Left(failure.toFailure);
    } catch (error) {
      var failure = const Failure('Default Error Message'); //Todo: Change String
      return Left(failure);
    }
  }
}

class SumTransactionUseCaseInput {
  String userId;
  int month;
  int year;

  SumTransactionUseCaseInput(this.userId)
      : month = DateTime.now().month,
        year = DateTime.now().year;

  SumTransactionUseCaseInput.previous(this.userId)
      : month = DateTime.now().previousMonth().month,
        year = DateTime.now().previousMonth().year;
}
