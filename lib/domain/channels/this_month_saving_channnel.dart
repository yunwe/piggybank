import 'dart:async';

class ThisMonthSavingChannel {
  final StreamController<double> _streamController = StreamController<double>();

  Stream<double> get amount => _streamController.stream;

  void broadcast(double amount) {
    _streamController.add(amount);
  }
}
