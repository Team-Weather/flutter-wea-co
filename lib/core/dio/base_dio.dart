import 'package:dio/dio.dart';

class BaseDio {
  final _dio = Dio();

  BaseDio({
    required HttpClientAdapter httpClientAdapter,
  }) {
    _dio.httpClientAdapter = httpClientAdapter;
  }

  /// GET 요청 메서드
  /// @param path: 요청 주소
  /// @param queryParameters: 요청 쿼리
  /// @param headers: 요청 헤더
  /// @param connectTimeout: 유효 연결 시간
  /// @param receiveTimeout: 유효 응답 시간
  /// @return Response: Get 요청에 대한 응답
  Future<Response> get(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      Duration? connectTimeout,
      Duration? receiveTimeout}) async {
    return await _dio.get(path,
        queryParameters: queryParameters,
        options: Options(
            headers: headers,
            receiveTimeout: receiveTimeout,
            sendTimeout: connectTimeout));
  }
}
