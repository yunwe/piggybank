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

  Wallet copyWith({
    bool? isArchived,
    DateTime? archivedDate,
    double? amount,
  }) {
    return Wallet(
      id: id,
      ownerId: ownerId,
      title: title,
      startDate: startDate,
      amount: amount ?? this.amount,
      targetAmount: targetAmount,
      targetEndDate: targetEndDate,
      isArchived: isArchived ?? this.isArchived,
      archivedDate: archivedDate ?? this.archivedDate,
    );
  }

  @override
  List<Object?> get props => [id, amount, isArchived];
}

extension WalletExtension on Wallet {
  bool get isTargetDateReached {
    if (targetEndDate == null) {
      return false;
    }

    return targetEndDate!.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch;
  }
}
