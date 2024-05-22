class Failure {
  final String message;

  const Failure(this.message);

  static const empty = Failure('');
}
