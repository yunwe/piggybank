import '../model/models.dart';

abstract class BaseException implements Exception {
  /// The associated error message.
  final String message;

  const BaseException(this.message);

  Failure get toFailure {
    return Failure(message);
  }
}
