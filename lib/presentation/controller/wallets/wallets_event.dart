part of 'wallets_bloc.dart';

sealed class WalletsEvent {
  const WalletsEvent();
}

final class WalletsChanged extends WalletsEvent {
  const WalletsChanged(this.wallets);

  final List<Wallet> wallets;
}

final class WalletsRequested extends WalletsEvent {
  const WalletsRequested({required this.userId});

  final String userId;
}
