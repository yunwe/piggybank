import 'package:either_dart/either.dart';
import 'package:piggybank/domain/model/failure.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';

class CreateWalletUseCase implements BaseUseCase<CreateWalletUseCaseInput, void> {
  final WalletRepository _repository;

  CreateWalletUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(CreateWalletUseCaseInput input) async {
    try {
      await _repository.create(
        userId: input.userId,
        title: input.title,
        targetAmount: input.targetAmount,
        targetEndDate: input.targetDate,
      );
      return const Right(null);
    } on BaseException catch (failure) {
      return Left(failure.toFailure);
    } catch (error) {
      var failure = const Failure('Default Error Message'); //Todo: Change String
      return Left(failure);
    }
  }
}

class CreateWalletUseCaseInput {
  String userId;
  String title;
  double? targetAmount;
  DateTime? targetDate;

  CreateWalletUseCaseInput({
    required this.userId,
    required this.title,
    this.targetAmount,
    this.targetDate,
  });
}
