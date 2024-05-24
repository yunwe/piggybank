import 'dart:async';

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
    on<PageInitialized>(_onPageInitialized);
    _walletsSubscription = _walletsChannel.wallets.listen(
      (wallets) => add(WalletListChanged(wallets)),
    );
    add(const PageInitialized());
  }

  final String userId;
  final WalletsChannel _walletsChannel;
  late final StreamSubscription<List<Wallet>> _walletsSubscription;

  final ListWalletUseCase _listWalletUseCase;

  void _onWalletsUpdated(WalletListChanged event, Emitter<HomePageState> emit) {
    emit(HomePageState.result(event.wallets));
  }

  void _onPageInitialized(PageInitialized event, Emitter<HomePageState> emit) {
    ListWalletUseCaseInput input = ListWalletUseCaseInput(userId);
    _listWalletUseCase.execute(input);

    emit(const HomePageState.loading());
  }

  @override
  Future<void> close() {
    _walletsSubscription.cancel();
    return super.close();
  }
}
