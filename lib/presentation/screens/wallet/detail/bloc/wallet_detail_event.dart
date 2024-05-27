part of 'wallet_detail_bloc.dart';

sealed class WalletDetailEvent extends Equatable {
  const WalletDetailEvent();

  @override
  List<Object?> get props => [];
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
