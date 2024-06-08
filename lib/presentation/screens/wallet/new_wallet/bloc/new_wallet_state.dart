part of 'new_wallet_bloc.dart';

final class NewWalletState extends Equatable {
  const NewWalletState({
    this.status = FormzSubmissionStatus.initial,
    this.goalName = const WalletName.pure(),
    this.icon = IconType.saving,
    this.targetAmount = const Amount.pure(),
    this.targetDate = const WalletTargetDate.pure(),
    this.setTarget = false,
    this.isValid = false,
    this.failure = Failure.empty,
  });

  final FormzSubmissionStatus status;
  final WalletName goalName;
  final IconType icon;
  final Amount targetAmount;
  final WalletTargetDate targetDate;
  final bool setTarget;
  final bool isValid;
  final Failure failure;

  NewWalletState copyWith({
    FormzSubmissionStatus? status,
    WalletName? goalName,
    IconType? icon,
    Amount? targetAmount,
    WalletTargetDate? targetDate,
    bool? setTarget,
    bool? isValid,
    Failure? failure,
  }) {
    return NewWalletState(
      status: status ?? this.status,
      goalName: goalName ?? this.goalName,
      icon: icon ?? this.icon,
      targetAmount: targetAmount ?? this.targetAmount,
      targetDate: targetDate ?? this.targetDate,
      setTarget: setTarget ?? this.setTarget,
      isValid: isValid ?? this.isValid,
      failure: failure ?? Failure.empty,
    );
  }

  @override
  List<Object> get props => [status, goalName, icon, setTarget, targetAmount, targetDate, failure];
}
