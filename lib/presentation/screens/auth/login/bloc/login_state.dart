part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.rememberMe = true,
    this.isValid = false,
    this.failure = Failure.empty,
  });

  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final bool rememberMe;
  final bool isValid;
  final Failure failure;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Password? password,
    bool? rememberMe,
    bool? isValid,
    Failure? failure,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isValid: isValid ?? this.isValid,
      failure: failure ?? Failure.empty,
    );
  }

  @override
  List<Object> get props => [status, username, password, rememberMe, failure];
}
