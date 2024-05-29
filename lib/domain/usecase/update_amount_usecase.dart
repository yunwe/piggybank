import 'package:either_dart/either.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/transaction_repository.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';
import 'package:piggybank/presentation/resources/app_strings.dart';

class UpdateAmountUseCase implements BaseUseCase<UpdateAmountUseCaseInput, void> {
  final WalletRepository walletRepository;
  final TransactionRepository transactionRepository;

  UpdateAmountUseCase({required this.walletRepository, required this.transactionRepository});

  @override
  Future<Either<Failure, void>> execute(UpdateAmountUseCaseInput input) async {
    try {
      Wallet? wallet = walletRepository.getFromCache(input.walletId);
      if (wallet == null) {
        return const Left(Failure(AppStrings.noWallet));
      }

      await walletRepository.update(
        wallet: wallet,
        amount: wallet.amount + input.amount,
      );
      await transactionRepository.create(
        wallet: wallet,
        amount: input.amount,
        remark: input.remark,
      );
      walletRepository.list(wallet.ownerId);

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
  String walletId;
  double amount;
  String? remark;

  UpdateAmountUseCaseInput({
    required this.walletId,
    required this.amount,
    this.remark,
  });
}