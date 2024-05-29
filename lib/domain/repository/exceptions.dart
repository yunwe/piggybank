import '../model/models.dart';

abstract class BaseException implements Exception {
  /// The associated error message.
  final String message;

  const BaseException(this.message);

  Failure get toFailure {
    return Failure(message);
  }
}

class ConnectionFailure extends BaseException {
  const ConnectionFailure([super.message = 'Please check your internet connnection.']);
}

/// Thrown during the logout process if a failure occurs.
class FirestoreFailure extends BaseException {
  const FirestoreFailure([super.message = 'An unknown exception occurred.']);
}
