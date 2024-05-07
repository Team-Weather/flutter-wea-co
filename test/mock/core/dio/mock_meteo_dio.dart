import 'package:weaco/core/dio/base_dio.dart';
import 'package:weaco/core/dio/base_response.dart';

class MockMeteoDio implements BaseDio {
  int getCallCount = 0;
  String getPathParameter = '';
  Map<String, dynamic>? getQueryParametersParameter;
  Map<String, dynamic>? getHeadersParameter;
  Duration? getConnectTimeoutParameter;
  Duration? getReceiveTimeoutParameter;
  BaseResponse getResponseReturnData = BaseResponse(statusCode: -1, body: {});

  void initMockData() {
    getCallCount = 0;
    getResponseReturnData = BaseResponse(statusCode: -1, body: {});
    getQueryParametersParameter = null;
    getHeadersParameter = null;
    getConnectTimeoutParameter = null;
    getReceiveTimeoutParameter = null;
  }

  @override
  Future<BaseResponse> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) async {
    getCallCount++;
    getPathParameter = path;
    getQueryParametersParameter = queryParameters;
    getHeadersParameter = headers;
    getConnectTimeoutParameter = connectTimeout;
    getReceiveTimeoutParameter = receiveTimeout;
    return getResponseReturnData;
  }
}
