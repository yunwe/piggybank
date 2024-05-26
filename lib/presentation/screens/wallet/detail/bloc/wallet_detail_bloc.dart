import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/archive_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/delete_wallet_usecase.dart';

part 'wallet_detail_event.dart';
part 'wallet_detail_state.dart';

class WalletDetailBloc extends Bloc<WalletDetailEvent, WalletDetialState> {
  WalletDetailBloc({
    required Wallet wallet,
    required ArchiveWalletUseCase archiveUseCase,
    required DeleteWalletUseCase deleteUseCase,
  })  : _archiveUseCase = archiveUseCase,
        _deleteUseCase = deleteUseCase,
        super(WalletDetialState.pure(wallet)) {
    on<ArchiveRequested>(_onArchiveRequested);
    on<DeleteRequested>(_onDeleteRequested);
  }

  final ArchiveWalletUseCase _archiveUseCase;
  final DeleteWalletUseCase _deleteUseCase;

  void _onArchiveRequested(
    ArchiveRequested event,
    Emitter<WalletDetialState> emit,
  ) async {
    emit(WalletDetialState.processing(state.wallet));
    Either<Failure, Wallet> value = await _archiveUseCase.execute(ArchiveWalletUseCaseInput(state.wallet));

    if (value.isLeft) {
      emit(WalletDetialState.error(
        value.left,
        state.wallet,
      ));
    } else {
      emit(WalletDetialState.pure(value.right));
    }
  }

  void _onDeleteRequested(
    DeleteRequested event,
    Emitter<WalletDetialState> emit,
  ) async {
    emit(WalletDetialState.processing(state.wallet));
    Either<Failure, void> value = await _deleteUseCase.execute(DeleteWalletUseCaseInput(state.wallet));

    if (value.isLeft) {
      emit(WalletDetialState.error(
        value.left,
        state.wallet,
      ));
    } else {
      emit(WalletDetialState.deleted(state.wallet));
    }
  }
}
