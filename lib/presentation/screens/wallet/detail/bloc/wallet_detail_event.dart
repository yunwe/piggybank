part of 'wallet_detail_bloc.dart';

sealed class WalletDetailEvent extends Equatable {
  const WalletDetailEvent();

  @override
  List<Object?> get props => [];
}

final class WalletDetailPageInitialzed extends WalletDetailEvent {
  const WalletDetailPageInitialzed({required this.walletId});

  final String walletId;

  @override
  List<Object> get props => [walletId];
}

final class WalletDetailArchiveRequested extends WalletDetailEvent {
  const WalletDetailArchiveRequested();

  @override
  List<Object?> get props => [];
}

final class WalletDetailDeleteRequested extends WalletDetailEvent {
  const WalletDetailDeleteRequested();

  @override
  List<Object?> get props => [];
}

final class WalletDetailTargetDateReached extends WalletDetailEvent {
  const WalletDetailTargetDateReached();

  @override
  List<Object?> get props => [];
}

final class WalletDetailTargetAmountReached extends WalletDetailEvent {
  const WalletDetailTargetAmountReached();

  @override
  List<Object?> get props => [];
}

final class WalletDetailWalletUpdated extends WalletDetailEvent {
  const WalletDetailWalletUpdated({required this.wallet});

  final Wallet wallet;

  @override
  List<Object> get props => [wallet];
}
