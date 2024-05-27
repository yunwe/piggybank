import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/domain/channels/wallets_channel.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/list_wallet_usecase.dart';

part 'wallets_state.dart';
part 'wallets_event.dart';

class WalletsBloc extends Bloc<WalletsEvent, WalletsState> {
  WalletsBloc({
    required this.userId,
    required WalletsChannel walletsChannel,
    required ListWalletUseCase listWalletUseCase,
  })  : _walletsChannel = walletsChannel,
        _listWalletUseCase = listWalletUseCase,
        super(
          const WalletsState.loading(),
        ) {
    on<WalletListChanged>(_onWalletsUpdated);
    on<WalletListRequested>(_onWalletListRequested);
    _walletsSubscription = _walletsChannel.wallets.listen(
      (wallets) => add(WalletListChanged(wallets)),
    );
    add(const WalletListRequested());
  }

  final String userId;
  final WalletsChannel _walletsChannel;
  late final StreamSubscription<List<Wallet>> _walletsSubscription;

  final ListWalletUseCase _listWalletUseCase;

  void _onWalletsUpdated(WalletListChanged event, Emitter<WalletsState> emit) {
    emit(WalletsState.result(event.wallets));
  }

  void _onWalletListRequested(WalletListRequested event, Emitter<WalletsState> emit) async {
    ListWalletUseCaseInput input = ListWalletUseCaseInput(userId);

    emit(const WalletsState.loading());

    Either<Failure, void> value = await _listWalletUseCase.execute(input);
    if (value.isLeft) {
      emit(WalletsState.error(value.left));
    }
  }

  @override
  Future<void> close() {
    _walletsSubscription.cancel();
    return super.close();
  }
}
