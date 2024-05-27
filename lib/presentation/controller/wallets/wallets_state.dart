part of 'wallets_bloc.dart';

enum WalletsStatus {
  loading,
  result,
  fail,
}

class WalletsState extends Equatable {
  const WalletsState._({
    required this.status,
    this.wallets = const <Wallet>[],
    this.failure,
  });

  const WalletsState.loading() : this._(status: WalletsStatus.loading);

  const WalletsState.result(List<Wallet> wallets) : this._(status: WalletsStatus.result, wallets: wallets);

  const WalletsState.error(Failure failure) : this._(status: WalletsStatus.fail, failure: failure);

  final WalletsStatus status;
  final List<Wallet> wallets;
  final Failure? failure;

  @override
  List<Object?> get props => [status, wallets, failure];
}
