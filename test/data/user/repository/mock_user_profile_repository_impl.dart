import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_profile_repository.dart';

class MockUserProfileRepositoryImpl implements UserProfileRepository {
  int getUserProfileCallCount = 0;
  final Map<String, UserProfile> _fakeUserProfileMap = {};

  /// [_fakeUserProfileMap]에서 이메일에 맞는 프로필을 찾아서 반환
  /// 이메일과 일치하지 프로필이 없는 경우, null 반환
  /// 호출시 [getUserProfileCallCount] + 1
  @override
  Future<UserProfile?> getUserProfile({required String email}) {
    getUserProfileCallCount++;
    return Future.value(_fakeUserProfileMap[email]);
  }

  /// [_fakeUserProfileMap]에 프로필을 추가
  void addProfile({required UserProfile profile}) {
    _fakeUserProfileMap[profile.email] = profile;
  }

}