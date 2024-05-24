import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/create_wallet_usecase.dart';
import 'package:piggybank/presentation/screens/new_wallet/model/models.dart';

part 'new_wallet_event.dart';
part 'new_wallet_state.dart';

class NewWalletBloc extends Bloc<NewWalletEvent, NewWalletState> {
  NewWalletBloc({required this.userId, required CreateWalletUseCase useCase})
      : _useCase = useCase,
        super(const NewWalletState()) {
    on<NewWalletSetTargetChanged>(_onSetTargetChanged);
    on<NewWalletGoalNameChanged>(_onGoalNameChanged);
    on<NewWalletTargetAmountChanged>(_onTargetAmountChanged);
    on<NewWalletTargetDateChanged>(_onTargetDateChanged);
    on<NewWalletSubmitted>(_onNewWalletSubmitted);
  }

  final CreateWalletUseCase _useCase;
  final String userId;

  void _onSetTargetChanged(
    NewWalletSetTargetChanged event,
    Emitter<NewWalletState> emit,
  ) {
    emit(
      state.copyWith(
        setTarget: event.setTarget,
      ),
    );
  }

  void _onGoalNameChanged(
    NewWalletGoalNameChanged event,
    Emitter<NewWalletState> emit,
  ) {
    final goalName = WalletName.dirty(event.goalName);
    final isValid = state.setTarget
        ? Formz.validate(
            [goalName, state.targetAmount, state.targetDate],
          )
        : Formz.validate(
            [goalName],
          );

    emit(
      state.copyWith(
        goalName: goalName,
        isValid: isValid,
      ),
    );
  }

  void _onTargetAmountChanged(
    NewWalletTargetAmountChanged event,
    Emitter<NewWalletState> emit,
  ) {
    final targetAmount = WalletTargetAmount.dirty(event.targetAmount);

    emit(
      state.copyWith(
        targetAmount: targetAmount,
        isValid: Formz.validate(
          [state.goalName, targetAmount, state.targetDate],
        ),
      ),
    );
  }

  void _onTargetDateChanged(
    NewWalletTargetDateChanged event,
    Emitter<NewWalletState> emit,
  ) {
    final targetDate = WalletTargetDate.dirty(event.targetDate);
    emit(
      state.copyWith(
        targetDate: targetDate,
        isValid: Formz.validate(
          [state.goalName, state.targetAmount, targetDate],
        ),
      ),
    );
  }

  void _onNewWalletSubmitted(
    NewWalletSubmitted event,
    Emitter<NewWalletState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress,
      ));

      CreateWalletUseCaseInput input = CreateWalletUseCaseInput(
        userId: userId,
        title: state.goalName.value,
        targetAmount: state.setTarget ? double.parse(state.targetAmount.value) : null,
        targetDate: state.setTarget ? state.targetDate.value : null,
      );
      print('Processing - ${state.goalName.value}');
      Either<Failure, void> value = await _useCase.execute(input);

      if (value.isLeft) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          failure: value.left,
        ));
        print('failed');
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
        print('success');
      }
    }
  }
}
