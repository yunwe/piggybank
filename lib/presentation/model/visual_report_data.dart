// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:piggybank/app/service/format_date.dart';
import 'package:piggybank/domain/model/models.dart';

const MILLION = 1000000;
const TEN_THOUSAND = 10000;
const THOUSAND = 1000;

const MONTHS_IN_YEAR = 12;

class VisualReportData {
  static const int _COL = 6;
  static const int MAX_ROW = 6;
  static const intervals = [1, 2, 5];

  final Wallet wallet;
  final List<Transaction> transactions;

  late final List<RodData> dataList;
  late final double maxY;
  late final double interval;
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

    //Find interval, maxY to have equal interval in all segments in barchar
    //if we don't provide maxY, the top-most segment will have the smaller segment
    var tempMaxY = (max / multiplier).ceil();
    final totalDigit = tempMaxY.toString().length;
    var power = 0;
    if (totalDigit > 2) {
      power = totalDigit - 2;
      tempMaxY = (tempMaxY / (pow(10, power))).ceil();
    }

    if (tempMaxY > intervals.last * MAX_ROW) {
      power = power + 1;
      tempMaxY = (tempMaxY / 10).ceil();
    }

    for (var num in intervals) {
      double potentialRow = tempMaxY / num;
      if (potentialRow <= MAX_ROW) {
        interval = num * pow(10, power).toDouble();
        maxY = potentialRow.ceil() * interval;
        break;
      }
    }
  }

  List<RodData> _process() {
    DateTime now = DateTime.now();
    int yearDiff = now.year - wallet.startDate.year;
    int monthDiff = ((yearDiff * MONTHS_IN_YEAR) + now.month) - wallet.startDate.month;
    DateTime startDate = monthDiff >= _COL ? now.previousMonth(month: _COL) : wallet.startDate;

    List<RodData> list = [];
    for (int i = 0; i < _COL; i++) {
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
