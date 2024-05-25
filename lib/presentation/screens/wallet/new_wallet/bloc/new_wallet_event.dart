part of 'new_wallet_bloc.dart';

sealed class NewWalletEvent extends Equatable {
  const NewWalletEvent();

  @override
  List<Object?> get props => [];
}

final class NewWalletGoalNameChanged extends NewWalletEvent {
  final String goalName;

  const NewWalletGoalNameChanged({required this.goalName});

  @override
  List<Object?> get props => [goalName];
}

final class NewWalletTargetAmountChanged extends NewWalletEvent {
  final String targetAmount;

  const NewWalletTargetAmountChanged({required this.targetAmount});

  @override
  List<Object?> get props => [targetAmount];
}

final class NewWalletTargetDateChanged extends NewWalletEvent {
  final DateTime? targetDate;

  const NewWalletTargetDateChanged({this.targetDate});

  @override
  List<Object?> get props => [targetDate];
}

final class NewWalletSetTargetChanged extends NewWalletEvent {
  final bool setTarget;

  const NewWalletSetTargetChanged({required this.setTarget});

  @override
  List<Object?> get props => [setTarget];
}

final class NewWalletSubmitted extends NewWalletEvent {
  const NewWalletSubmitted();
}
