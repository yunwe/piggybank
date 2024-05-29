import 'package:either_dart/either.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/transaction_repository.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';

class UpdateAmountUseCase implements BaseUseCase<UpdateAmountUseCaseInput, void> {
  final WalletRepository walletRepository;
  final TransactionRepository transactionRepository;

  UpdateAmountUseCase({required this.walletRepository, required this.transactionRepository});

  @override
  Future<Either<Failure, void>> execute(UpdateAmountUseCaseInput input) async {
    try {
      await walletRepository.update(
        wallet: input.wallet,
        amount: input.wallet.amount + input.amount,
      );
      await transactionRepository.create(
        wallet: input.wallet,
        amount: input.amount,
        remark: input.remark,
      );
      walletRepository.list(input.wallet.ownerId);

      return const Right(null);
    } on BaseException catch (failure) {
      return Left(failure.toFailure);
    } catch (error) {
      var failure = const Failure('Default Error Message'); //TODO: Change String
      return Left(failure);
    }
  }
}

class UpdateAmountUseCaseInput {
  Wallet wallet;
  double amount;
  String? remark;

  UpdateAmountUseCaseInput({
    required this.wallet,
    required this.amount,
    this.remark,
  });
}
