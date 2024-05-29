part of 'wallet_detail_bloc.dart';

sealed class WalletDetailEvent extends Equatable {
  const WalletDetailEvent();

  @override
  List<Object?> get props => [];
}

final class WalletDetailPageInitialzed extends WalletDetailEvent {
  const WalletDetailPageInitialzed({required this.wallets, required this.walletId});

  final List<Wallet> wallets;
  final String walletId;

  @override
  List<Object> get props => [walletId, wallets];
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
