part of 'home_bloc.dart';

sealed class HomePageEvent {
  const HomePageEvent();
}

final class WalletListChanged extends HomePageEvent {
  const WalletListChanged(this.wallets);

  final List<Wallet> wallets;
}

final class PageInitialized extends HomePageEvent {
  const PageInitialized();
}
