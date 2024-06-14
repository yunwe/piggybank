import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/reset_passwrod_usecase.dart';
import 'package:piggybank/presentation/screens/auth/models/models.dart';

part 'recover_event.dart';
part 'recover_state.dart';

class RecoverBloc extends Bloc<RecoverEvent, RecoverState> {
  RecoverBloc({required ResetPasswordUseCase useCase})
      : _useCase = useCase,
        super(const RecoverState()) {
    on<RecoverUsernameChanged>(_onUsernameChanged);
    on<RecoverSubmitted>(_onSubmitted);
  }

  final ResetPasswordUseCase _useCase;

  void _onUsernameChanged(
    RecoverUsernameChanged event,
    Emitter<RecoverState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        username: username,
        isValid: Formz.validate([username]),
      ),
    );
  }

  Future<void> _onSubmitted(
    RecoverSubmitted event,
    Emitter<RecoverState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      ResetPasswordUseCaseInput input =
          ResetPasswordUseCaseInput(state.username.value);
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
