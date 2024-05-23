part of 'new_wallet_bloc.dart';

final class NewWalletState extends Equatable {
  const NewWalletState({
    this.status = FormzSubmissionStatus.initial,
    this.goalName = const WalletName.pure(),
    this.targetAmount = const WalletTargetAmount.pure(),
    this.targetDate = const WalletTargetDate.pure(),
    this.setTarget = false,
    this.isValid = false,
    this.failure = Failure.empty,
  });

  final FormzSubmissionStatus status;
  final WalletName goalName;
  final WalletTargetAmount targetAmount;
  final WalletTargetDate targetDate;
  final bool setTarget;
  final bool isValid;
  final Failure failure;

  NewWalletState copyWith({
    FormzSubmissionStatus? status,
    WalletName? goalName,
    WalletTargetAmount? targetAmount,
    WalletTargetDate? targetDate,
    bool? setTarget,
    bool? isValid,
    Failure? failure,
  }) {
    return NewWalletState(
      status: status ?? this.status,
      goalName: goalName ?? this.goalName,
      targetAmount: targetAmount ?? this.targetAmount,
      targetDate: targetDate ?? this.targetDate,
      setTarget: setTarget ?? this.setTarget,
      isValid: isValid ?? this.isValid,
      failure: failure ?? Failure.empty,
    );
  }

  @override
  List<Object> get props => [status, goalName, setTarget, targetAmount, targetDate, failure];
}
