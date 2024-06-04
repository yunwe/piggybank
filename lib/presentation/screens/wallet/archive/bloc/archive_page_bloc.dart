import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/domain/model/models.dart';

part 'archive_page_event.dart';
part 'archive_page_state.dart';

class ArchivePageBloc extends Bloc<ArchivePageEvent, ArchivePageState> {
  ArchivePageBloc()
      : super(
          const ArchivePageState(wallets: []),
        ) {
    on<ArchivePageWalletsChanged>(_onHomePageWalletsUpdated);
  }

  void _onHomePageWalletsUpdated(ArchivePageWalletsChanged event, Emitter<ArchivePageState> emit) {
    //Filter Out Archived Wallets
    List<Wallet> validWallets = event.wallets.where((element) => element.isArchived).toList();
    validWallets.sort((a, b) => b.archivedDate!.compareTo(a.archivedDate!));

    if (listEquals(validWallets, state.wallets)) {
      return;
    }

    emit(ArchivePageState(wallets: validWallets));
  }
}
