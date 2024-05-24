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
}
