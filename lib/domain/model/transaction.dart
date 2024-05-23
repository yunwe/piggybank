import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final String walletId;
  final DateTime createdTime;
  final double amount;
  final String? remarks;

  const Transaction({
    required this.id,
    required this.walletId,
    required this.createdTime,
    required this.amount,
    this.remarks = '',
  });

  @override
  List<Object?> get props => [id, walletId, createdTime, amount, remarks];
}
