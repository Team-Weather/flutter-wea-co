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
  Future<List<String>> saveImage({required File croppedImage, required File compressedImage}) async {
    methodCallCount['saveImage'] = (methodCallCount['method'] ?? 0) + 1;
    methodParameter['image'] = croppedImage;
    return methodResult['saveImage'];
  }
}
