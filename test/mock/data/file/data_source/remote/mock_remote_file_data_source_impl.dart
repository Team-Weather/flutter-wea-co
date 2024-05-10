import 'dart:io';

import 'package:weaco/data/file/data_source/remote/remote_file_data_source.dart';

class MockRemoteFileDataSourceImpl implements RemoteFileDataSource {
  final Map<String, int> methodCallCount = {};
  final Map<String, dynamic> methodResult = {};
  final Map<String, dynamic> methodParameter = {};

  void initMockData() {
    methodResult.clear();
    methodParameter.clear();
    methodCallCount.clear();
  }

  @override
  Future<String> saveImage({required File image}) async {
    methodCallCount['saveImage'] = (methodCallCount['method'] ?? 0) + 1;
    methodParameter['image'] = image;
    return methodResult['saveImage'];
  }
}
