import 'package:either_dart/either.dart';
import 'package:piggybank/domain/model/models.dart';
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
        icon: input.icon,
        targetAmount: input.targetAmount,
        targetEndDate: input.targetDate,
      );
      _repository.list(input.userId);
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
  int icon;
  double? targetAmount;
  DateTime? targetDate;

  CreateWalletUseCaseInput({
    required this.userId,
    required this.title,
    required this.icon,
    this.targetAmount,
    this.targetDate,
  });
}
