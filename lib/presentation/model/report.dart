import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/domain/model/models.dart';

class Report {
  final Wallet wallet;

  Report({required this.wallet});

  DateTime get startDate => wallet.startDate;

  //Show in Percentage

  String get activePeriod {
    final duration = wallet.isArchived ? wallet.archivedDate!.difference(wallet.startDate).inDays : _activeDays;
    return _parseDays(duration);
  }

  double get currentAmount => wallet.amount;

  double get averageSaving {
    int month = DateTime.now().monthDifference(wallet.startDate) + 1;
    return currentAmount / month;
  }

  int get _activeDays {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime startDay = DateTime(wallet.startDate.year, wallet.startDate.month, wallet.startDate.day);

    int days = today.difference(startDay).inDays;
    if (days == 0) {
      return 1;
    }
    return days;
  }

  String _parseDays(int day) {
    //Days
    if (day < 30) {
      return day <= 1 ? '1 day' : '$day days';
    }

    //Month
    if (day < 365) {
      final month = (day / 31).floor();
      return month == 1 ? '1 month' : '$month months';
    }

    //Year
    final year = (day / 365).floor();
    final extraMonth = ((day % 365) / 31).ceil();
    return year == 1 ? '1 year $extraMonth months' : '$year years $extraMonth months';
  }
}

class TargetReport extends Report {
  TargetReport({required super.wallet});

  DateTime get endDate => wallet.targetEndDate!;

  double get targetAmount => wallet.targetAmount!;

  double get dayAchievement {
    return _activeDays / _duration.inDays;
  }

  double get amountAchievement {
    return currentAmount / wallet.targetAmount!;
  }

  double get amountToSave {
    return targetAmount / (_duration.inDays / 30);
  }

  String get endIn {
    int days = _duration.inDays;
    return _parseDays(days - _activeDays);
  }

  Duration get _duration {
    DateTime startDate = DateTime(wallet.startDate.year, wallet.startDate.month, wallet.startDate.day);
    DateTime endDate = wallet.targetEndDate!;
    return endDate.difference(startDate);
  }
}
