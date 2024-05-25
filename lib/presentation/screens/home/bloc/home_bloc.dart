import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/domain/channels/wallets_channel.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/list_wallet_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc({
    required this.userId,
    required WalletsChannel walletsChannel,
    required ListWalletUseCase listWalletUseCase,
  })  : _walletsChannel = walletsChannel,
        _listWalletUseCase = listWalletUseCase,
        super(
          const HomePageState.loading(),
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

  void _onWalletsUpdated(WalletListChanged event, Emitter<HomePageState> emit) {
    emit(HomePageState.result(event.wallets));
  }

  void _onWalletListRequested(WalletListRequested event, Emitter<HomePageState> emit) async {
    ListWalletUseCaseInput input = ListWalletUseCaseInput(userId);

    emit(const HomePageState.loading());

    Either<Failure, void> value = await _listWalletUseCase.execute(input);
    if (value.isLeft) {
      emit(HomePageState.error(value.left));
    }
  }

  @override
  Future<void> close() {
    _walletsSubscription.cancel();
    return super.close();
  }
}
