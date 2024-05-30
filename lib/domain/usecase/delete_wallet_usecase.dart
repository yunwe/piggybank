import 'package:either_dart/either.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';

class DeleteWalletUseCase implements BaseUseCase<DeleteWalletUseCaseInput, void> {
  final WalletRepository _repository;

  DeleteWalletUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(DeleteWalletUseCaseInput input) async {
    try {
      await _repository.delete(
        wallet: input.wallet,
      );
      _repository.list(input.wallet.ownerId);
      return const Right(null);
    } on BaseException catch (failure) {
      return Left(failure.toFailure);
    } catch (error) {
      var failure = const Failure('Default Error Message'); //Todo: Change String
      return Left(failure);
    }
  }
}

class DeleteWalletUseCaseInput {
  Wallet wallet;

  DeleteWalletUseCaseInput(this.wallet);
}
