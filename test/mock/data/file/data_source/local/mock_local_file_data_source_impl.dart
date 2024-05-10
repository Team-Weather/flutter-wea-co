import 'dart:io';
import 'package:weaco/data/file/data_source/local/local_file_data_source.dart';

class MockLocalFileDataSourceImpl implements LocalFileDataSource {
  final Map<String, int> methodCallCount = {};
  final Map<String, dynamic> methodResult = {};
  final Map<String, dynamic> methodParameter = {};

  void initMockData() {
    methodResult.clear();
    methodParameter.clear();
    methodCallCount.clear();
  }

  @override
  Future<File?> getImage({required bool isOrigin}) async {
    methodCallCount['getImage'] = (methodCallCount['getImage'] ?? 0) + 1;
    methodParameter['isOrigin'] = isOrigin;
    return methodResult['getImage'];
  }

  @override
  Future<bool> saveImage({required bool isOrigin, required File file}) async {
    methodCallCount['saveImage'] = (methodCallCount['saveImage'] ?? 0) + 1;
    methodParameter['isOrigin'] = isOrigin;
    methodParameter['file'] = file;
    return methodResult['saveImage'];
  }
}
