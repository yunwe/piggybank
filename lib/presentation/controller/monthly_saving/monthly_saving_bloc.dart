import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/domain/usecase/sum_transaction_usecase.dart';

part 'monthly_saving_event.dart';
part 'monthly_saving_state.dart';

class MonthlySavingBloc extends Bloc<MonthlySavingEvent, MonthlySavingState> {
  MonthlySavingBloc({
    required SumTransactionUseCase sumTransactionUseCase,
  })  : _sumTransactionUseCase = sumTransactionUseCase,
        super(
          const MonthlySavingState(),
        ) {
    on<MonthlySavingRequested>(_onRequestedd);
    on<MonthlySavingUpdated>(_onUpdated);
  }

  final SumTransactionUseCase _sumTransactionUseCase;

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

  void _onUpdated(MonthlySavingUpdated event, Emitter<MonthlySavingState> emit) async {
    double lastMonthSaving = 0;
    Either<Failure, double> valueForLastMonth = await _sumTransactionUseCase.execute(SumTransactionUseCaseInput.previous(event.userId));
    if (valueForLastMonth.isRight) {
      lastMonthSaving = valueForLastMonth.right;
    }

    emit(MonthlySavingState(
      thisMonth: state.thisMonth,
      lastMonth: lastMonthSaving,
    ));
  }
}
