import 'package:either_dart/either.dart';
import 'package:piggybank/domain/channels/this_month_saving_channnel.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/repository/exceptions.dart';
import 'package:piggybank/domain/repository/transaction_repository.dart';
import 'package:piggybank/domain/repository/wallet_repository.dart';
import 'package:piggybank/domain/usecase/base_usecase.dart';
import 'package:piggybank/presentation/resources/resources.dart';

class UpdateAmountUseCase implements BaseUseCase<UpdateAmountUseCaseInput, void> {
  final WalletRepository walletRepository;
  final TransactionRepository transactionRepository;
  final ThisMonthSavingChannel thisMonthSavingChannel;

  UpdateAmountUseCase({
    required this.walletRepository,
    required this.transactionRepository,
    required this.thisMonthSavingChannel,
  });

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

      //Update wallet list
      walletRepository.list(wallet.ownerId);

      //Update this month saving
      final value = await transactionRepository.sum(wallet.ownerId, DateTime.now().month, DateTime.now().year);
      thisMonthSavingChannel.broadcast(value);

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
