import 'package:dio/dio.dart';

class BaseDio {
  final _dio = Dio();

  BaseDio({required HttpClientAdapter httpClientAdapter, }) {
    _dio.httpClientAdapter = httpClientAdapter;
  }

  Future<Response> get(
      {required String path, Map<String, dynamic>? queryParameters, Duration? connectTimeout, Duration? receiveTimeout}) async {
    return await _dio.get(path, queryParameters: queryParameters, options: Options(receiveTimeout: receiveTimeout, sendTimeout: connectTimeout));
  }
}
