import 'dart:io';
import 'package:weaco/domain/file/repository/file_repository.dart';

class MockFileRepositoryImpl implements FileRepository {
  int getImageCallCount = 0;
  int saveImageCallCount = 0;
  int saveOotdImageCallCount = 0;
  final Map<String, dynamic> methodParameterMap = {};
  File? getImageResult;
  String saveOotdImageResult = '';
  bool saveImageResult = false;

  void initMockData() {
    getImageCallCount = 0;
    saveImageCallCount = 0;
    saveOotdImageCallCount = 0;
    methodParameterMap.clear();
    saveOotdImageResult = '';
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
  Future<String> saveOotdImage() async {
    saveOotdImageCallCount++;
    return saveOotdImageResult;
  }
}
