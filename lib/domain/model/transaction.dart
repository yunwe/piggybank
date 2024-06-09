import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final String walletId;
  final String userId;
  final DateTime createdTime;
  final double amount;
  final double updatedBalance;
  final String? remarks;

  const Transaction({
    required this.id,
    required this.walletId,
    required this.userId,
    required this.createdTime,
    required this.amount,
    required this.updatedBalance,
    this.remarks = '',
  });

  @override
  List<Object?> get props => [id, walletId, userId, createdTime, amount, updatedBalance, remarks];
}
