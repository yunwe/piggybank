part of 'wallet_transaction_bloc.dart';

final class WalletTransactionState extends Equatable {
  const WalletTransactionState({
    this.wallet,
    this.status = FormzSubmissionStatus.initial,
    this.amount = const Amount.pure(),
    this.remark,
    this.isWithdrawl = false,
    this.isValid = false,
    this.failure = Failure.empty,
    this.message,
  });

  final Wallet? wallet;
  final FormzSubmissionStatus status;
  final Amount amount;
  final String? remark;
  final bool isWithdrawl;
  final bool isValid;
  final Failure failure;
  final String? message;

  WalletTransactionState copyWith({
    FormzSubmissionStatus? status,
    Amount? amount,
    String? remark,
    bool? isWithdrawl,
    bool? isValid,
    Failure? failure,
    String? message,
  }) {
    return WalletTransactionState(
      status: status ?? this.status,
      amount: amount ?? this.amount,
      remark: remark ?? this.remark,
      isWithdrawl: isWithdrawl ?? this.isWithdrawl,
      isValid: isValid ?? this.isValid,
      failure: failure ?? Failure.empty,
      message: message,
      wallet: wallet,
    );
  }

  @override
  List<Object?> get props => [status, amount, remark, isWithdrawl, isValid, failure];
}
