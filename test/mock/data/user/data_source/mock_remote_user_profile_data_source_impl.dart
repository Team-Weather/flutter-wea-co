import 'package:weaco/data/user/data_source/remote_user_profile_data_source.dart';
import 'package:weaco/domain/user/model/user_profile.dart';

class MockRemoteUserProfileDataSourceImpl
    implements RemoteUserProfileDataSource {
  int methodCallCount = 0;
  UserProfile? getUserProfileResult;
  bool isRemoved = false;
  bool isSaved = false;
  bool isUpdated = false;

  void initMockData() {
    methodCallCount = 0;
    getUserProfileResult = null;
    isRemoved = false;
    isSaved = false;
    isUpdated = false;
  }

  @override
  Future<UserProfile> getUserProfile({String? email}) {
    methodCallCount++;
    return Future.value(getUserProfileResult);
  }

  @override
  Future<bool> updateUserProfile({UserProfile? userProfile}) async {
    methodCallCount++;
    return isUpdated;
  }

  @override
  Future<bool> saveUserProfile({required UserProfile userProfile}) async {
    methodCallCount++;
    return isSaved;
  }

  @override
  Future<bool> removeUserProfile({String? email}) async {
    methodCallCount++;
    return isRemoved;
  }
}
