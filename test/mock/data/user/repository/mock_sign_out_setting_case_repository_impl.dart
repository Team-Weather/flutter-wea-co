import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class MockSignOutSettingRepositoryImpl implements UserAuthRepository {
  Map<String, UserProfile> _fakeUserProfileMap = {};
  bool isSignOut = false;

  @override
  Future<bool> signOutSetting({required String email}) async {
    if ( _fakeUserProfileMap[email] != null) {
      isSignOut = true;
    }
    return isSignOut;
  }

  void addProfile({required UserProfile profile}) {
    _fakeUserProfileMap[profile.email] = profile;
  }

  void initMockData() {
    _fakeUserProfileMap = {};
    isSignOut = false;
  }
}
