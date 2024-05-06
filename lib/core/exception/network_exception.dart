sealed class NetworkException implements Exception {
  factory NetworkException.noData() = NoDataException;

  factory NetworkException.errorCode({required String code}) = ErrorResponseCodeException;

  factory NetworkException.unknown({required String message}) =
      UnknownException;
}

class NoDataException implements NetworkException {
  NoDataException();
}

class ErrorResponseCodeException implements NetworkException {
  final String code;
  ErrorResponseCodeException({required this.code});
}

class UnknownException implements NetworkException {
  final String message;

  UnknownException({required this.message});
}
