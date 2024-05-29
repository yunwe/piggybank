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
    required WalletsChannel walletsChannel,
    required ListWalletUseCase listWalletUseCase,
  })  : _walletsChannel = walletsChannel,
        _listWalletUseCase = listWalletUseCase,
        super(
          const WalletsState.loading(),
        ) {
    on<WalletsChanged>(_onWalletsUpdated);
    on<WalletsRequested>(_onWalletListRequested);
    _walletsSubscription = _walletsChannel.wallets.listen(
      (wallets) => add(WalletsChanged(wallets)),
    );
  }

  final WalletsChannel _walletsChannel;
  late final StreamSubscription<List<Wallet>> _walletsSubscription;

  final ListWalletUseCase _listWalletUseCase;

  void _onWalletsUpdated(WalletsChanged event, Emitter<WalletsState> emit) {
    emit(WalletsState.result(event.wallets));
  }

  void _onWalletListRequested(WalletsRequested event, Emitter<WalletsState> emit) async {
    ListWalletUseCaseInput input = ListWalletUseCaseInput(event.userId);
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
