import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/app/service/format_string.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/archive_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/delete_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/get_wallet_usecase.dart';
import 'package:piggybank/domain/usecase/list_transaction_usecase.dart';
import 'package:piggybank/presentation/resources/resources.dart';

part 'wallet_detail_event.dart';
part 'wallet_detail_state.dart';

class WalletDetailBloc extends Bloc<WalletDetailEvent, WalletDetialState> {
  WalletDetailBloc({
    required GetWalletUseCase getWalletUseCase,
    required ListTransactionUseCase listTransactionUseCase,
    required ArchiveWalletUseCase archiveUseCase,
    required DeleteWalletUseCase deleteUseCase,
  })  : _getWalletUseCase = getWalletUseCase,
        _listTransactionUseCase = listTransactionUseCase,
        _archiveUseCase = archiveUseCase,
        _deleteUseCase = deleteUseCase,
        super(const WalletDetialState(status: DetailPageStatus.processing)) {
    on<WalletDetailPageInitialzed>(_onPageInitialzed);
    on<WalletDetailWalletUpdated>(_onWalletUpdated);
    on<WalletDetailArchiveRequested>(_onArchiveRequested);
    on<WalletDetailDeleteRequested>(_onDeleteRequested);
    on<WalletDetailTargetDateReached>(_onTargetDateReached);
    on<WalletDetailTargetAmountReached>(_onTargetAmountReached);
  }

  final GetWalletUseCase _getWalletUseCase;
  final ListTransactionUseCase _listTransactionUseCase;
  final ArchiveWalletUseCase _archiveUseCase;
  final DeleteWalletUseCase _deleteUseCase;

  void _onPageInitialzed(
    WalletDetailPageInitialzed event,
    Emitter<WalletDetialState> emit,
  ) async {
    emit(WalletDetialState(status: DetailPageStatus.processing, wallet: state.wallet));

    //Get Wallet
    Either<Failure, Wallet?> walletValue = await _getWalletUseCase.execute(GetWalletUseCaseInput(event.walletId));
    if (walletValue.isLeft) {
      return emit(state.copyWith(status: DetailPageStatus.fail, failure: walletValue.left));
    }

    //Get Transactions
    Either<Failure, List<Transaction>> transactionsValue = await _listTransactionUseCase.execute(ListTransactionUseCaseInput(event.walletId));
    if (transactionsValue.isLeft) {
      return emit(state.copyWith(status: DetailPageStatus.fail, failure: transactionsValue.left));
    }

    //Success State
    return emit(WalletDetialState(
      status: DetailPageStatus.pure,
      wallet: walletValue.right,
      transactions: transactionsValue.right,
    ));
  }

  void _onWalletUpdated(
    WalletDetailWalletUpdated event,
    Emitter<WalletDetialState> emit,
  ) async {
    //Get Transactions
    Either<Failure, List<Transaction>> transactionsValue = await _listTransactionUseCase.execute(
      ListTransactionUseCaseInput(event.wallet.id),
    );
    if (transactionsValue.isLeft) {
      return emit(
        state.copyWith(status: DetailPageStatus.fail, failure: transactionsValue.left),
      );
    }

    //If the updated wallet is not get from event,
    //have to get it from cache,
    //the cache might not be updated yet.
    return emit(WalletDetialState(
      status: DetailPageStatus.pure,
      wallet: event.wallet,
      transactions: transactionsValue.right,
    ));
  }

  void _onArchiveRequested(
    WalletDetailArchiveRequested event,
    Emitter<WalletDetialState> emit,
  ) async {
    if (state.wallet == null) {
      return;
    }

    emit(state.copyWith(status: DetailPageStatus.processing));
    Either<Failure, Wallet> value = await _archiveUseCase.execute(ArchiveWalletUseCaseInput(state.wallet!));

    if (value.isLeft) {
      emit(state.copyWith(status: DetailPageStatus.fail, failure: value.left));
    } else {
      emit(
        WalletDetialState(
          status: DetailPageStatus.pure,
          wallet: value.right,
          message: AppStrings.messageWalletArchived.format([value.right.title]),
        ),
      );
    }
  }

  void _onDeleteRequested(
    WalletDetailDeleteRequested event,
    Emitter<WalletDetialState> emit,
  ) async {
    if (state.wallet == null) {
      return;
    }

    emit(state.copyWith(status: DetailPageStatus.processing));
    Either<Failure, void> value = await _deleteUseCase.execute(DeleteWalletUseCaseInput(state.wallet!));

    if (value.isLeft) {
      emit(state.copyWith(status: DetailPageStatus.fail, failure: value.left));
    } else {
      emit(state.copyWith(status: DetailPageStatus.deleted));
    }
  }

  void _onTargetDateReached(
    WalletDetailTargetDateReached event,
    Emitter<WalletDetialState> emit,
  ) async {
    if (state.wallet == null) {
      return;
    }

    emit(state.copyWith(status: DetailPageStatus.targetReached, message: AppStrings.targetDateReached));
  }

  void _onTargetAmountReached(
    WalletDetailTargetAmountReached event,
    Emitter<WalletDetialState> emit,
  ) async {
    if (state.wallet == null) {
      return;
    }

    emit(
      state.copyWith(
        status: DetailPageStatus.targetReached,
        message: AppStrings.targetAmountReached.format([state.wallet!.title]),
      ),
    );
  }
}
