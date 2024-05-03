import 'package:weaco/domain/common/file/repository/file_repository.dart';

class MockFileRepositoryImpl implements FileRepository {
  int saveDataCallCount = 0;
  int removeCroppedImageCallCount = 0;
  final Map<String, dynamic> methodParameterMap = {};
  bool fakeSaveDataResult = false;
  bool fakeRemoveCroppedImageResult = false;

  void initMockData() {
    saveDataCallCount = 0;
    removeCroppedImageCallCount = 0;
    methodParameterMap.clear();
    fakeRemoveCroppedImageResult = false;
    fakeSaveDataResult = false;
  }

  @override
  Future<bool> saveData({required List<int> data}) async {
    saveDataCallCount++;
    methodParameterMap['data'] = data;
    return fakeSaveDataResult;
  }

  @override
  Future<bool> removeCroppedImage() async {
    removeCroppedImageCallCount++;
    return fakeRemoveCroppedImageResult;
  }
}
