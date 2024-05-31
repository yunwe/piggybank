import 'package:piggybank/domain/model/models.dart';

class Report {
  final Wallet wallet;

  Report({required this.wallet});

  DateTime get startDate => wallet.startDate;

  //Show in Percentage

  String get activePeriod {
    final duration = wallet.isArchived ? wallet.archivedDate!.difference(wallet.startDate).inDays : _activeDays;

    //Days
    if (duration < 30) {
      return duration <= 1 ? '1 day' : '$duration days';
    }

    //Month
    if (duration < 365) {
      final month = (duration / 30).floor();
      return month == 1 ? '1 month+' : '$month months+';
    }

    //Year
    final year = (duration / 365).floor();
    return year == 1 ? '1 year+' : '$year years+';
  }

  double get currentAmount => wallet.amount;

  double get averageSaving {
    int month = (_activeDays / 30).ceil();
    return currentAmount / month;
  }

  int get _activeDays {
    int days = DateTime.now().difference(wallet.startDate).inDays;
    if (days == 0) {
      return 1;
    }
    return days;
  }
}

class TargetReport extends Report {
  TargetReport({required super.wallet});

  DateTime get endDate => wallet.targetEndDate!;

  double get targetAmount => wallet.targetAmount!;

  double get dayAchievement {
    final target = wallet.targetEndDate!.difference(wallet.startDate).inDays;
    return _activeDays / target;
  }

  double get amountAchievement {
    return currentAmount / wallet.targetAmount!;
  }

  double get amountToSave {
    return targetAmount / (_activeDays / 30).ceil();
  }

  double get amountSaving {
    return currentAmount / (_activeDays / 30).ceil();
  }
}
