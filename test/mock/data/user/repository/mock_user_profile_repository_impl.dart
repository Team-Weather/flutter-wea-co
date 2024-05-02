import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_profile_repository.dart';

class MockUserProfileRepositoryImpl implements UserProfileRepository {
  int getUserProfileCallCount = 0;
  int getMyProfileCallCount = 0;

  // 메서드 호출시 인자 확인을 위한 map
  final Map<String, dynamic> methodParameterMap = {};
  final Map<String, UserProfile> _fakeUserProfileMap = {};

  /// [_fakeUserProfileMap]에서 이메일에 맞는 프로필을 찾아서 반환
  /// 이메일과 일치하지 프로필이 없는 경우, null 반환
  /// 호출시 [getUserProfileCallCount] + 1
  @override
  Future<UserProfile?> getUserProfile({required String email}) {
    getUserProfileCallCount++;
    methodParameterMap['email'] = email;
    return Future.value(_fakeUserProfileMap[email]);
  }

  /// [_fakeUserProfileMap]에 프로필을 추가
  void addProfile({required UserProfile profile}) {
    _fakeUserProfileMap[profile.email] = profile;
  }

  /// [_fakeUserProfileMap]에 마이 프로필을 추가
  void addMyProfile({required UserProfile profile}) {
    _fakeUserProfileMap['my'] = profile;
  }

  /// [_fakeUserProfileMap]의 모든 프로필 삭제
  void resetProfile() {
    _fakeUserProfileMap.clear();
  }

  /// 호출 횟수 초기화
  void resetCallCount() {
    getUserProfileCallCount = 0;
    getMyProfileCallCount = 0;
  }

  /// 호출시 [getMyProfileCallCount] + 1
  /// [_fakeUserProfileMap]에서 'my'에 해당하는 프로필을 반환
  @override
  Future<UserProfile?> getMyProfile() async {
    getMyProfileCallCount++;
    return _fakeUserProfileMap['my'];
  }
}

