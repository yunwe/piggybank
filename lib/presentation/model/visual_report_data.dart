// ignore_for_file: constant_identifier_names
import 'dart:math' as mathf;
import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/domain/model/models.dart';

const MILLION = 1000000;
const TEN_THOUSAND = 10000;
const THOUSAND = 1000;

class VisualReportData {
  final Wallet wallet;
  final List<Transaction> transactions;

  late final List<RodData> dataList;
  late final double maxAmount;
  late final int multiplier;
  late final String? unit;

  VisualReportData({required this.wallet, required this.transactions}) {
    var rawList = _process();
    //Find max amount
    double max = 0;
    for (var element in rawList) {
      if (element.saving > max) {
        max = element.saving;
      }
      if (element.withdrawl > max) {
        max = element.withdrawl;
      }
    }

    //Define unit for better UX
    if (max >= MILLION) {
      unit = 'm';
      multiplier = MILLION;
    } else if (max >= TEN_THOUSAND) {
      unit = 'k';
      multiplier = THOUSAND;
    } else {
      unit = null;
      multiplier = 1;
    }

    //Set Data
    dataList = multiplier == 1 ? rawList : rawList.map((e) => RodData(e.title, e.saving / multiplier, e.withdrawl / multiplier)).toList();
    maxAmount = max / multiplier;
  }

  List<RodData> _process() {
    DateTime now = DateTime.now();
    int yearDiff = now.year - wallet.startDate.year;
    int monthDiff = ((yearDiff * 12) + now.month) - wallet.startDate.month;
    DateTime startDate = monthDiff >= 6 ? now.previousMonth(month: 6) : wallet.startDate;

    List<RodData> list = [];
    for (int i = 0; i < 6; i++) {
      DateTime reportMonth = startDate.addMonth(i);
      var summairze = _summarize(reportMonth.month, reportMonth.year);
      list.add(RodData(monthNames[reportMonth.month - 1], summairze.$1, summairze.$2));
    }
    return list;
  }

  //month => 1..12
  //year => DateTime.year
  (double, double) _summarize(int month, int year) {
    List<Transaction> monthlyTran = transactions.where((element) => _sameMonth(element, month, year)).toList();
    double totalSaving = 0;
    double totalWithdrawl = 0;
    for (int i = 0; i < monthlyTran.length; i++) {
      final element = monthlyTran[i];
      if (element.amount > 0) {
        totalSaving += element.amount;
      } else {
        totalWithdrawl += element.amount * -1;
      }
    }

    return (totalSaving, totalWithdrawl);
  }

  bool _sameMonth(Transaction t, int month, int year) {
    return t.createdTime.year == year && t.createdTime.month == month;
  }
}

class RodData {
  const RodData(this.title, this.saving, this.withdrawl);

  final String title;
  final double saving;
  final double withdrawl;
}
