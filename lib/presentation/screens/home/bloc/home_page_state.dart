part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  const HomePageState({required this.wallets});

  final List<Wallet> wallets;

  @override
  List<Object?> get props => [wallets];
}
