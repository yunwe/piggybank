mixin DataParser {
  static double toDouble(dynamic value) {
    return double.tryParse(value.toString()) ?? 0;
  }

  static DateTime toDateTime(dynamic value) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }

  static DateTime? toNullableDateTime(dynamic value) {
    if (value == null) {
      return null;
    }

    return toDateTime(value!);
  }

  static int get currentTimestamp => DateTime.now().millisecondsSinceEpoch;
}
