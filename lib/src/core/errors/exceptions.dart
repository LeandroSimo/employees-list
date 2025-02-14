class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class NetWorkException implements Exception {
  final String message;

  NetWorkException(this.message);
}
