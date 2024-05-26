part of 'home_bloc.dart';

enum HomePageStatus {
  loading,
  result,
  fail,
}

class HomePageState extends Equatable {
  const HomePageState._({
    required this.status,
    this.wallets = const <Wallet>[],
    this.failure,
  });

  const HomePageState.loading() : this._(status: HomePageStatus.loading);

  const HomePageState.result(List<Wallet> wallets) : this._(status: HomePageStatus.result, wallets: wallets);

  const HomePageState.error(Failure failure) : this._(status: HomePageStatus.fail, failure: failure);

  final HomePageStatus status;
  final List<Wallet> wallets;
  final Failure? failure;

  @override
  List<Object?> get props => [status, wallets, failure];
}
