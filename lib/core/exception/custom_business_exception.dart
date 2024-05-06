class CustomBusinessException implements Exception {
  final int code;
  final String message;

  CustomBusinessException({required this.code, required this.message});
}
