import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/signup_usercase.dart';
import 'package:piggybank/presentation/screens/models/models.dart';
import 'package:piggybank/presentation/screens/models/password_confirm.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required SignupUseCase useCase})
      : _useCase = useCase,
        super(const RegisterState()) {
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  final SignupUseCase _useCase;

  void _onUsernameChanged(
    RegisterUsernameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        username: username,
        isValid: Formz.validate([
          username,
          state.password,
          state.confirmation,
        ]),
      ),
    );
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        password: password,
        isValid: Formz.validate([
          state.username,
          password,
          state.confirmation,
        ]),
      ),
    );
  }

  void _onConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final confirmPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: event.password,
    );
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        confirmation: confirmPassword,
        isValid: Formz.validate([
          state.username,
          state.password,
          confirmPassword,
        ]),
      ),
    );
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      SignupUseCaseInput input =
          SignupUseCaseInput(state.username.value, state.password.value);
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
