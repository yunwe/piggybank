part of 'wallet_detail_bloc.dart';

enum DetailPageStatus { processing, pure, fail, deleted }

class WalletDetialState extends Equatable {
  const WalletDetialState({
    required this.status,
    this.wallet,
    this.failure,
    this.message,
  });

  WalletDetialState copyWith({
    required DetailPageStatus status,
    Wallet? wallet,
    String? message,
    Failure? failure,
  }) {
    //Failure and Message from previous state
    //are not reusable
    return WalletDetialState(
      status: status,
      wallet: wallet ?? this.wallet,
      failure: failure,
      message: message,
    );
  }

  final DetailPageStatus status;
  final Wallet? wallet;
  final Failure? failure;
  final String? message;

  @override
  List<Object?> get props => [status, wallet];
}
