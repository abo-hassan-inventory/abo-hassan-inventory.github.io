class Failure {
  final String message;
  Failure(this.message);
}

class RemoteDataException implements Exception {
  final String message;
  RemoteDataException(this.message);
  @override
  String toString() => 'RemoteDataException: $message';
}
