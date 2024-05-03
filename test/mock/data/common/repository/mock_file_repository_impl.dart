import 'package:weaco/domain/common/file/repository/file_repository.dart';

class MockFileRepositoryImpl implements FileRepository {
  int saveDataCallCount = 0;
  final Map<String, dynamic> methodParameterMap = {};
  bool fakeSaveDataResult = false;

  void initMockData() {
    saveDataCallCount = 0;
    methodParameterMap.clear();
    fakeSaveDataResult = false;
  }

  @override
  Future<bool> saveData({required List<int> data}) async {
    saveDataCallCount++;
    methodParameterMap['data'] = data;
    return fakeSaveDataResult;
  }
}
