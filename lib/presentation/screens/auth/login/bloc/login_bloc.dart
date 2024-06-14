import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/login_usecase.dart';
import 'package:piggybank/presentation/screens/auth/models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginUseCase useCase})
      : _useCase = useCase,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginPersistenceChanged>(_onPersistenceChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final LoginUseCase _useCase;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        username: username,
        isValid: Formz.validate([state.password, username]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        password: password,
        isValid: Formz.validate([password, state.username]),
      ),
    );
  }

  void _onPersistenceChanged(
    LoginPersistenceChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(rememberMe: event.isOn),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      LoginUseCaseInput input = LoginUseCaseInput(
          state.username.value, state.password.value, state.rememberMe);
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
