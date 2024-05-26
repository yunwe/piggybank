part of 'wallet_detail_bloc.dart';

sealed class WalletDetailEvent extends Equatable {
  const WalletDetailEvent();

  @override
  List<Object?> get props => [];
}

final class ArchiveRequested extends WalletDetailEvent {
  const ArchiveRequested();

  @override
  List<Object?> get props => [];
}

final class DeleteRequested extends WalletDetailEvent {
  const DeleteRequested();

  @override
  List<Object?> get props => [];
}
