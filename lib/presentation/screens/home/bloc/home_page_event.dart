part of 'home_page_bloc.dart';

sealed class HomePageEvent {
  const HomePageEvent();
}

final class HomePageWalletsChanged extends HomePageEvent {
  const HomePageWalletsChanged(this.wallets);

  final List<Wallet> wallets;
}
