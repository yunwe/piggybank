import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/app/service/format_string.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/get_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/update_amount_usecase.dart';
import 'package:piggybank/presentation/resources/app_strings.dart';
import 'package:piggybank/presentation/screens/wallet/model/models.dart';

part 'wallet_transaction_event.dart';
part 'wallet_transaction_state.dart';

class WalletTransactionBloc extends Bloc<WalletTransactionEvent, WalletTransactionState> {
  WalletTransactionBloc({
    required UpdateAmountUseCase updateUseCase,
    required GetWalletUseCase getUseCase,
  })  : _getUseCase = getUseCase,
        _updateUseCase = updateUseCase,
        super(const WalletTransactionState()) {
    on<WalletTransactionPageInitialized>(_onPageInitialized);
    on<WalletTransactionAmountChanged>(_onAmountChanged);
    on<WalletTransactionRemarkChanged>(_onRemarkChanged);
    on<WalletTransactionModeChanged>(_onModeChanged);
    on<WalletTransactionSubmitted>(_onSubmitted);
  }

  final UpdateAmountUseCase _updateUseCase;
  final GetWalletUseCase _getUseCase;

  void _onPageInitialized(
    WalletTransactionPageInitialized event,
    Emitter<WalletTransactionState> emit,
  ) async {
    Either<Failure, Wallet?> value = await _getUseCase.execute(GetWalletUseCaseInput(event.walletId));

    if (value.isLeft) {
      emit(state.copyWith(failure: value.left));
    } else {
      return emit(WalletTransactionState(wallet: value.right));
    }
  }

  void _onAmountChanged(
    WalletTransactionAmountChanged event,
    Emitter<WalletTransactionState> emit,
  ) {
    final amount = Amount.dirty(event.amount);
    emit(
      state.copyWith(
        amount: amount,
        isValid: Formz.validate([amount]),
      ),
    );
  }

  void _onRemarkChanged(
    WalletTransactionRemarkChanged event,
    Emitter<WalletTransactionState> emit,
  ) {
    final remark = Remark.dirty(event.remark);
    emit(
      state.copyWith(remark: remark),
    );
  }

  void _onModeChanged(
    WalletTransactionModeChanged event,
    Emitter<WalletTransactionState> emit,
  ) {
    emit(
      state.copyWith(isWithdrawl: event.isWithdrawl),
    );
  }

  Future<void> _onSubmitted(
    WalletTransactionSubmitted event,
    Emitter<WalletTransactionState> emit,
  ) async {
    if (state.wallet == null) {
      return;
    }

    Wallet wallet = state.wallet!;

    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      double transactionAmount = double.parse(state.amount.value);
      if (state.isWithdrawl && transactionAmount > wallet.amount) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          failure: const Failure(AppStrings.messageExceedingFund),
        ));
      }

      final sign = state.isWithdrawl ? -1 : 1;
      UpdateAmountUseCaseInput input = UpdateAmountUseCaseInput(
        walletId: wallet.id,
        amount: transactionAmount * sign,
        remark: state.remark.value,
      );
      Either<Failure, void> value = await _updateUseCase.execute(input);
      if (value.isLeft) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          failure: value.left,
        ));
      } else {
        String message = state.isWithdrawl ? AppStrings.messageWithdrawn : AppStrings.messageAddedFund;

        emit(state.copyWith(
          status: FormzSubmissionStatus.success,
          amount: const Amount.pure(),
          remark: const Remark.pure(),
          message: message.format([state.amount.value, wallet.title]),
        ));
      }
    }
  }
}
