part of 'register_bloc.dart';

final class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.confirmation = const ConfirmPassword.pure(),
    this.isValid = false,
    this.failure = Failure.empty,
  });

  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final ConfirmPassword confirmation;
  final bool isValid;
  final Failure failure;

  RegisterState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Password? password,
    ConfirmPassword? confirmation,
    bool? isValid,
    Failure? failure,
  }) {
    return RegisterState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmation: confirmation ?? this.confirmation,
      isValid: isValid ?? this.isValid,
      failure: failure ?? Failure.empty,
    );
  }

  @override
  List<Object> get props => [status, username, password, confirmation, failure];
}
