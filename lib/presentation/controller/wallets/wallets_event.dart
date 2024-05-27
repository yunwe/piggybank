part of 'wallets_bloc.dart';

sealed class WalletsEvent {
  const WalletsEvent();
}

final class WalletListChanged extends WalletsEvent {
  const WalletListChanged(this.wallets);

  final List<Wallet> wallets;
}

final class WalletListRequested extends WalletsEvent {
  const WalletListRequested();
}
