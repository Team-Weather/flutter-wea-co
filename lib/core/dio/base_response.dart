class BaseResponse {
  final int? statusCode;
  final Map<String, dynamic> body;

  BaseResponse({required this.statusCode, required this.body});
}
