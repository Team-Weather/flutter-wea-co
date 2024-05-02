import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class MockLogOutSettingRepositoryImpl implements UserAuthRepository {
  final Map<String, UserProfile> _fakeUserProfileMap = {};
  bool isLoggedOut = false;

  @override
  Future<bool> logOutSetting({required String email}) async {
    if ( _fakeUserProfileMap[email] != null) {
      isLoggedOut = true;
    }
    return isLoggedOut;
  }

  void addProfile({required UserProfile profile}) {
    _fakeUserProfileMap[profile.email] = profile;
  }

  void initMockData() {
    isLoggedOut = false;
  }
}
