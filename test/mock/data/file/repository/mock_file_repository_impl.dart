import 'dart:io';
import 'package:weaco/domain/file/repository/file_repository.dart';

class MockFileRepositoryImpl implements FileRepository {
  int getImageCallCount = 0;
  int saveImageCallCount = 0;
  final Map<String, dynamic> methodParameterMap = {};
  File? getImageResult;
  bool saveImageResult = false;

  void initMockData() {
    getImageCallCount = 0;
    saveImageCallCount = 0;
    methodParameterMap.clear();
  }

  @override
  Future<File?> getImage({required bool isOrigin}) async {
    getImageCallCount++;
    return getImageResult;
  }

  @override
  Future<bool> saveImage({required bool isOrigin, required File file}) async {
    saveImageCallCount++;
    methodParameterMap['data'] = file;
    return saveImageResult;
  }

  @override
  Future<String> saveOotdImage() {
    // TODO: implement saveFeed
    throw UnimplementedError();
  }
}
