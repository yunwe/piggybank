part of 'recover_bloc.dart';

sealed class RecoverEvent extends Equatable {
  const RecoverEvent();

  @override
  List<Object> get props => [];
}

final class RecoverUsernameChanged extends RecoverEvent {
  const RecoverUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class RecoverSubmitted extends RecoverEvent {
  const RecoverSubmitted();
}
