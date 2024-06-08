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

  factory HomePageState.empty() {
    return const HomePageState(
      wallets: [],
      status: HomePageStatus.result,
      walletCount: 0,
      totalAmount: 0,
    );
  }

  HomePageState copyWith() {
    return HomePageState(
      status: HomePageStatus.result,
      wallets: wallets,
      walletCount: walletCount,
      totalAmount: totalAmount,
    );
  }

  final List<Wallet> wallets;
  final HomePageStatus status;

  final int walletCount;
  final double totalAmount;

  @override
  List<Object?> get props => [status, wallets];
}
