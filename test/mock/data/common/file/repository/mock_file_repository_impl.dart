import 'dart:io';
import 'package:weaco/domain/common/file/repository/file_repository.dart';


class MockFileRepositoryImpl implements FileRepository {
  int getOriginImageCallCount = 0;
  int saveDataCallCount = 0;
  int getCroppedImageCallCount = 0;
  final Map<String, dynamic> methodParameterMap = {};
  File? getOriginImageResult;
  bool fakeSaveDataResult = false;
  File? getCroppedImageResult;

  void initMockData() {
    saveDataCallCount = 0;
    getCroppedImageCallCount = 0;
    getOriginImageCallCount = 0;
    methodParameterMap.clear();
    fakeSaveDataResult = false;
    getCroppedImageResult = null;
    getOriginImageResult = null;
  }

  @override
  Future<File?> getOriginImage() async {
    getOriginImageCallCount++;
    return getOriginImageResult;
  }

  @override
  Future<bool> saveData({required List<int> data}) async {
    saveDataCallCount++;
    methodParameterMap['data'] = data;
    return fakeSaveDataResult;
  }

  @override
  Future<File?> getCroppedImage() async {
    getCroppedImageCallCount++;
    return getCroppedImageResult;
  }
}