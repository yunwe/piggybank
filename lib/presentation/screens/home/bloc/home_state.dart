part of 'home_bloc.dart';

enum HomePageStatus {
  loading,
  result,
}

class HomePageState extends Equatable {
  const HomePageState._({
    required this.status,
    this.wallets = const <Wallet>[],
  });

  const HomePageState.loading() : this._(status: HomePageStatus.loading);

  const HomePageState.result(List<Wallet> wallets) : this._(status: HomePageStatus.result, wallets: wallets);

  final HomePageStatus status;
  final List<Wallet> wallets;

  @override
  List<Object> get props => [status, wallets];
}
