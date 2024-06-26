import 'package:either_dart/either.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';

class ListWalletUseCase implements BaseUseCase<ListWalletUseCaseInput, void> {
  final WalletRepository _repository;

  ListWalletUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(ListWalletUseCaseInput input) async {
    try {
      await _repository.list(input.userId);
      return const Right(null);
    } on BaseException catch (failure) {
      return Left(failure.toFailure);
    } catch (error) {
      var failure = const Failure('Default Error Message'); //Todo: Change String
      return Left(failure);
    }
  }
}

class ListWalletUseCaseInput {
  String userId;

  ListWalletUseCaseInput(this.userId);
}
