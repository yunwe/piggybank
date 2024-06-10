import 'package:either_dart/either.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/transaction_repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';

class ListTransactionUseCase implements BaseUseCase<ListTransactionUseCaseInput, void> {
  final TransactionRepository _repository;

  ListTransactionUseCase(this._repository);

  @override
  Future<Either<Failure, List<Transaction>>> execute(ListTransactionUseCaseInput input) async {
    try {
      final transactions = await _repository.list(input.walletId);
      transactions.sort((a, b) => b.createdTime.compareTo(a.createdTime));
      return Right(transactions);
    } on BaseException catch (failure) {
      return Left(failure.toFailure);
    } catch (error) {
      var failure = const Failure('Default Error Message'); //Todo: Change String
      return Left(failure);
    }
  }
}

class ListTransactionUseCaseInput {
  String walletId;

  ListTransactionUseCaseInput(this.walletId);
}
