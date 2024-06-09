import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/domain/channels/this_month_saving_channnel.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/sum_transaction_usecase.dart';

part 'monthly_saving_event.dart';
part 'monthly_saving_state.dart';

class MonthlySavingBloc extends Bloc<MonthlySavingEvent, MonthlySavingState> {
  MonthlySavingBloc({
    required SumTransactionUseCase sumTransactionUseCase,
    required ThisMonthSavingChannel thisMonthSavingChannel,
  })  : _sumTransactionUseCase = sumTransactionUseCase,
        _thisMonthSavingChannel = thisMonthSavingChannel,
        super(
          const MonthlySavingState(),
        ) {
    on<MonthlySavingRequested>(_onRequestedd);
    on<MonthlySavingThisMonthUpdated>(_onUpdated);
    _subscription = _thisMonthSavingChannel.amount.listen(
      (amount) => add(MonthlySavingThisMonthUpdated(amount: amount)),
    );
  }

  final SumTransactionUseCase _sumTransactionUseCase;
  final ThisMonthSavingChannel _thisMonthSavingChannel;

  late final StreamSubscription<double> _subscription;

  void _onRequestedd(MonthlySavingRequested event, Emitter<MonthlySavingState> emit) async {
    double thisMonthSaving = 0;
    double lastMonthSaving = 0;

    Either<Failure, double> valueForThisMonth = await _sumTransactionUseCase.execute(SumTransactionUseCaseInput(event.userId));
    if (valueForThisMonth.isRight) {
      thisMonthSaving = valueForThisMonth.right;
    }

    Either<Failure, double> valueForLastMonth = await _sumTransactionUseCase.execute(SumTransactionUseCaseInput.previous(event.userId));
    if (valueForLastMonth.isRight) {
      lastMonthSaving = valueForLastMonth.right;
    }

    emit(MonthlySavingState(
      thisMonth: thisMonthSaving,
      lastMonth: lastMonthSaving,
    ));
  }

  void _onUpdated(MonthlySavingThisMonthUpdated event, Emitter<MonthlySavingState> emit) async {
    emit(MonthlySavingState(
      thisMonth: event.amount,
      lastMonth: state.lastMonth,
    ));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
