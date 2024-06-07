part of 'home_page_bloc.dart';

enum HomePageStatus {
  processing,
  result,
}

class HomePageState extends Equatable {
  const HomePageState({
    required this.status,
    required this.wallets,
    required this.walletCount,
    required this.totalAmount,
    required this.totalSavedForCurrentMonth,
    required this.totalSavedForLastMonth,
  });

  factory HomePageState.processing() {
    return const HomePageState(
      wallets: [],
      status: HomePageStatus.processing,
      walletCount: 0,
      totalAmount: 0,
      totalSavedForCurrentMonth: 0,
      totalSavedForLastMonth: 0,
    );
  }

  final List<Wallet> wallets;
  final HomePageStatus status;

  final int walletCount;
  final double totalAmount;
  final double totalSavedForCurrentMonth;
  final double totalSavedForLastMonth;

  @override
  List<Object?> get props => [wallets];
}
