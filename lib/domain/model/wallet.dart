import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final String id;
  final String ownerId;
  final String title;
  final double amount;

  final DateTime startDate;

  final double? targetAmount;
  final DateTime? targetEndDate;

  final bool isArchived;
  final DateTime? archivedDate;

  const Wallet({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.startDate,
    required this.amount,
    this.targetAmount,
    this.targetEndDate,
    this.isArchived = false,
    this.archivedDate,
  });

  @override
  List<Object?> get props => [id, amount, isArchived];
}
