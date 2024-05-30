import 'package:either_dart/either.dart';
import 'package:piggybank/domain/model/failure.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';

class GetWalletUseCase implements BaseUseCase<GetWalletUseCaseInput, void> {
  final WalletRepository _repository;

  GetWalletUseCase(this._repository);

  @override
  Future<Either<Failure, Wallet?>> execute(GetWalletUseCaseInput input) async {
    try {
      Wallet? wallet = _repository.getFromCache(input.walletId);
      return Right(wallet);
    } on BaseException catch (failure) {
      return Left(failure.toFailure);
    } catch (error) {
      var failure = const Failure('Default Error Message');
      return Left(failure);
    }
  }
}

class GetWalletUseCaseInput {
  String walletId;

  GetWalletUseCaseInput(this.walletId);
}
