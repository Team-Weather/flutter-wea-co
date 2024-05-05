import 'dart:io';
import 'package:weaco/domain/common/file/repository/file_repository.dart';


class MockFileRepositoryImpl implements FileRepository {
  int getOriginImageCallCount = 0;
  int saveDataCallCount = 0;
  final Map<String, dynamic> methodParameterMap = {};
  File? getOriginImageResult;
  bool fakeSaveDataResult = false;

  void initMockData() {
    getOriginImageCallCount = 0;
    methodParameterMap.clear();
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
}