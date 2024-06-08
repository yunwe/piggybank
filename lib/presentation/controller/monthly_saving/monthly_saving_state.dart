part of 'monthly_saving_bloc.dart';

class MonthlySavingState extends Equatable {
  const MonthlySavingState({
    this.thisMonth,
    this.lastMonth,
  });

  final double? thisMonth;
  final double? lastMonth;

  @override
  List<Object?> get props => [thisMonth, lastMonth];
}
