part of 'wallet_transaction_bloc.dart';

sealed class WalletTransactionEvent extends Equatable {
  const WalletTransactionEvent();

  @override
  List<Object> get props => [];
}

final class WalletTransactionPageInitialized extends WalletTransactionEvent {
  const WalletTransactionPageInitialized(this.walletId);

  final String walletId;

  @override
  List<Object> get props => [walletId];
}

final class WalletTransactionAmountChanged extends WalletTransactionEvent {
  const WalletTransactionAmountChanged(this.amount);

  final String amount;

  @override
  List<Object> get props => [amount];
}

final class WalletTransactionRemarkChanged extends WalletTransactionEvent {
  const WalletTransactionRemarkChanged(this.remark);

  final String remark;

  @override
  List<Object> get props => [remark];
}

final class WalletTransactionModeChanged extends WalletTransactionEvent {
  const WalletTransactionModeChanged(this.isWithdrawl);

  final bool isWithdrawl;

  @override
  List<Object> get props => [isWithdrawl];
}

final class WalletTransactionSubmitted extends WalletTransactionEvent {
  const WalletTransactionSubmitted();
}
