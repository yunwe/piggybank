String interpolate(String string, List<String> params) {
  String result = string;
  for (int i = 1; i < params.length + 1; i++) {
    result = result.replaceAll('%$i\$', params[i - 1]);
  }

  return result;
}

extension StringExtension on String {
  String format(List<String> params) => interpolate(this, params);
}

extension NumExtension on double {
  String formatCurrency() {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return toStringAsFixed(0).replaceAllMapped(reg, (Match match) => '${match[1]},');
  }
}
