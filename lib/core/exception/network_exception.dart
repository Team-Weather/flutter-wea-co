sealed class NetworkException implements Exception {
  final String code;
  final String message;

  NetworkException({required this.code, required this.message});

  factory NetworkException.noData({required String code, required String message}) = NoDataException;

  factory NetworkException.errorCode({required String code, required String message}) = ErrorResponseCodeException;

  factory NetworkException.unknown({required String code, required String message}) =
      UnknownException;
}

class NoDataException extends NetworkException {
  NoDataException({required super.code, required super.message});
}

class ErrorResponseCodeException extends NetworkException {
  ErrorResponseCodeException({required super.code, required super.message});

}

class UnknownException extends NetworkException {
  UnknownException({required super.code, required super.message});
}
