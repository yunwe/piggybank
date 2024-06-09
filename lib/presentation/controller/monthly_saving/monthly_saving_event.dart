part of 'monthly_saving_bloc.dart';

sealed class MonthlySavingEvent {
  const MonthlySavingEvent();
}

final class MonthlySavingRequested extends MonthlySavingEvent {
  const MonthlySavingRequested({required this.userId});

  final String userId;
}

final class MonthlySavingThisMonthUpdated extends MonthlySavingEvent {
  const MonthlySavingThisMonthUpdated({required this.amount});

  final double amount;
}
