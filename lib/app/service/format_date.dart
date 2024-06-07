import 'dart:core';

const monthNames = [
  'JAN',
  'FEB',
  'MAR',
  'APR',
  'MAY',
  'JUN',
  'JUL',
  'AGU',
  'SEP',
  'OCT',
  'NOV',
  'DEC',
];

extension DateFormatting on DateTime {
  String format() {
    String day = this.day.toString().padLeft(2, '0');
    String month = monthNames[this.month - 1];
    String year = this.year.toString();
    return "$day $month $year";
  }

  String formatMonth() {
    String month = monthNames[this.month - 1];
    String year = this.year.toString();
    return "$month, $year";
  }
}

extension DateDifferennce on DateTime {
  DateTime previousMonth({int month = 1}) {
    int resMonth = this.month - month;

    if (resMonth <= 0) {
      return DateTime(year - 1, resMonth + 12);
    }

    return DateTime(year, resMonth);
  }

  DateTime addMonth([int month = 1]) {
    int resMonth = this.month + month;

    if (resMonth > 12) {
      int resYear = year + (resMonth / 12).floor();
      return DateTime(resYear, resMonth % 12);
    }
    return DateTime(year, resMonth);
  }

  int monthDifference(DateTime date2) {
    DateTime min, max;
    if (date2.millisecondsSinceEpoch > millisecondsSinceEpoch) {
      max = date2;
      min = this;
    } else {
      max = this;
      min = date2;
    }

    int yearDiff = max.year - min.year;
    return ((max.month + (yearDiff * 12)) - min.month);
  }
}
