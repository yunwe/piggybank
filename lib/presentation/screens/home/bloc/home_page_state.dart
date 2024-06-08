part of 'home_page_bloc.dart';

enum HomePageStatus {
  processing,
  result,
}

class HomePageState extends Equatable {
  const HomePageState({required this.status, required this.wallets, required this.walletCount, required this.totalAmount});

  factory HomePageState.processing() {
    return const HomePageState(
      wallets: [],
      status: HomePageStatus.processing,
      walletCount: 0,
      totalAmount: 0,
    );
  }

  final List<Wallet> wallets;
  final HomePageStatus status;

  final int walletCount;
  final double totalAmount;

  @override
  List<Object?> get props => [wallets];
}
