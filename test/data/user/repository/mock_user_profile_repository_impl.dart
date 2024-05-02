import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_profile_repository.dart';

class MockUserProfileRepositoryImpl implements UserProfileRepository {
  Map<String, UserProfile> _fakeUserProfileMap = {};

  @override
  Future<UserProfile?> getUserProfile({required String email}) async {
    return _fakeUserProfileMap[email];
  }

  void addProfile({required UserProfile userProfile}) {
    _fakeUserProfileMap[userProfile.email] = userProfile;
  }

  void initMockData() {
    _fakeUserProfileMap = {};
  }
}
