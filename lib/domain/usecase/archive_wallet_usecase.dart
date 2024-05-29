import 'package:either_dart/either.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';

class ArchiveWalletUseCase implements BaseUseCase<ArchiveWalletUseCaseInput, void> {
  final WalletRepository _repository;

  ArchiveWalletUseCase(this._repository);

  @override
  Future<Either<Failure, Wallet>> execute(ArchiveWalletUseCaseInput input) async {
    try {
      Wallet newWallet = await _repository.update(
        wallet: input.wallet,
        isArchived: true,
      );
      _repository.list(input.wallet.ownerId);
      return Right(newWallet);
    } on BaseException catch (failure) {
      return Left(failure.toFailure);
    } catch (error) {
      var failure = const Failure('Default Error Message'); //Todo: Change String
      return Left(failure);
    }
  }
}

class ArchiveWalletUseCaseInput {
  Wallet wallet;

  ArchiveWalletUseCaseInput(this.wallet);
}
