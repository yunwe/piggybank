import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final String walletId;
  final DateTime createdTime;
  final double amount;
  final double updatedBalance;
  final String? remarks;

  const Transaction({
    required this.id,
    required this.walletId,
    required this.createdTime,
    required this.amount,
    required this.updatedBalance,
    this.remarks = '',
  });

  @override
  List<Object?> get props => [id, walletId, createdTime, amount, updatedBalance, remarks];
}
