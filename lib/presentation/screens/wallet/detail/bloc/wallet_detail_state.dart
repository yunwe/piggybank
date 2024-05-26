part of 'wallet_detail_bloc.dart';

enum DetailPageStatus { processing, pure, fail, deleted }

class WalletDetialState extends Equatable {
  const WalletDetialState._({
    required this.status,
    required this.wallet,
    this.failure,
  });

  const WalletDetialState.processing(Wallet wallet) : this._(status: DetailPageStatus.processing, wallet: wallet);

  const WalletDetialState.pure(Wallet wallet) : this._(status: DetailPageStatus.pure, wallet: wallet);

  const WalletDetialState.error(Failure failure, Wallet wallet)
      : this._(
          status: DetailPageStatus.fail,
          wallet: wallet,
          failure: failure,
        );

  const WalletDetialState.deleted(Wallet wallet) : this._(status: DetailPageStatus.deleted, wallet: wallet);

  final DetailPageStatus status;
  final Wallet wallet;
  final Failure? failure;

  @override
  List<Object> get props => [status, wallet];
}
