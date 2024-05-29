import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/domain/model/models.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc()
      : super(
          const HomePageState(wallets: []),
        ) {
    on<HomePageWalletsChanged>(_onHomePageWalletsUpdated);
  }

  void _onHomePageWalletsUpdated(HomePageWalletsChanged event, Emitter<HomePageState> emit) {
    //Filter Out Archived Wallets
    List<Wallet> validWallets = event.wallets.where((element) => !element.isArchived).toList();
    validWallets.sort((a, b) => a.title.compareTo(b.title));

    if (listEquals(validWallets, state.wallets)) {
      return;
    }

    emit(HomePageState(wallets: validWallets));
  }
}
