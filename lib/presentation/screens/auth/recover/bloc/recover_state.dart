part of 'recover_bloc.dart';

final class RecoverState extends Equatable {
  const RecoverState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.isValid = false,
    this.failure = Failure.empty,
  });

  final FormzSubmissionStatus status;
  final Username username;
  final bool isValid;
  final Failure failure;

  RecoverState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    bool? isValid,
    Failure? failure,
  }) {
    return RecoverState(
      status: status ?? this.status,
      username: username ?? this.username,
      isValid: isValid ?? this.isValid,
      failure: failure ?? Failure.empty,
    );
  }

  @override
  List<Object> get props => [status, username, failure];
}
