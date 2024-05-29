import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/update_amount_usecase.dart';
import 'package:piggybank/presentation/screens/auth/models/amount.dart';

part 'wallet_transaction_event.dart';
part 'wallet_transaction_state.dart';

class WalletTransactionBloc extends Bloc<WalletTransactionEvent, WalletTransactionState> {
  WalletTransactionBloc({
    required UpdateAmountUseCase useCase,
    required String walletId,
  })  : _useCase = useCase,
        _walletId = walletId,
        super(const WalletTransactionState()) {
    on<WalletTransactionAmountChanged>(_onAmountChanged);
    on<WalletTransactionRemarkChanged>(_onRemarkChanged);
    on<WalletTransactionModeChanged>(_onModeChanged);
    on<WalletTransactionSubmitted>(_onSubmitted);
  }

  final UpdateAmountUseCase _useCase;
  final String _walletId;

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
    emit(
      state.copyWith(remark: event.remark),
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
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final sign = state.isWithdrawl ? -1 : 1;
      UpdateAmountUseCaseInput input = UpdateAmountUseCaseInput(
        walletId: _walletId,
        amount: double.parse(state.amount.value) * sign,
        remark: state.remark,
      );
      Either<Failure, void> value = await _useCase.execute(input);
      if (value.isLeft) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          failure: value.left,
        ));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }
    }
  }
}
