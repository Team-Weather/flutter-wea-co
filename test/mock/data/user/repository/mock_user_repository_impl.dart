import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_repository.dart';

class MockUserRepositoryImpl implements UserRepository {
  Map<String, UserProfile> _fakeUserProfileMap = {};
  bool isLoggedOut = false;

  @override
  Future<bool> logOutSetting({required String email}) async {
    if (_fakeUserProfileMap[email] != null) {
      isLoggedOut = true;
    }
    return isLoggedOut;
  }

  void addProfile({required UserProfile profile}) {
    _fakeUserProfileMap[profile.email] = profile;
  }

  void initMockData() {
    _fakeUserProfileMap = {};
    isLoggedOut = false;
  }
}
