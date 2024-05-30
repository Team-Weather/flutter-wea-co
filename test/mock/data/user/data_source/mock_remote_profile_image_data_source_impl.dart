import 'package:weaco/data/user/data_source/remote_profile_image_data_source.dart';
import 'package:weaco/domain/user/model/profile_image.dart';

class MockRemoteProfileImageDataSourceImpl
    implements RemoteProfileImageDataSource {
  int methodCallCount = 0;
  dynamic methodResult;
  final Map<String, dynamic> methodParameter = {};

  void initMockData() {
    methodCallCount = 0;
    methodResult = null;
    methodParameter.clear();
  }

  @override
  Future<List<ProfileImage>> getProfileImageList() async {
    methodCallCount++;
    return methodResult;
  }
}
