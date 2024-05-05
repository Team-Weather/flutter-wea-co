import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_repository.dart';

class SignUpUserUseCase {
  final UserRepository _userRepository;

  const SignUpUserUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  /// 회원 가입 화면에서 정보기입 후 가입 요청을 보내는 Use Case
  /// [userAuth] : 회원 가입을 위한 이메일, 비밀번호 정보
  /// [userProfile] : 회원 가입을 위한 프로필 정보
  /// 회원 가입 성공시 true 반환, 실패시 false 반환
  Future<bool?> execute(UserAuth userAuth, UserProfile userProfile, String email)
  async {
    final List<UserProfile> userProfileList = [];
    if (isRegistered(userProfile, email)) {
      return false;
    }

    userProfileList.add(UserProfile(
      email: userProfile.email,
      nickname: userProfile.nickname,
      gender: userProfile.gender,
      profileImagePath: userProfile.profileImagePath,
      feedCount: 0,
      createdAt: DateTime.now(),
      deletedAt: null,
    ));
    return null;
  }

  bool isRegistered(UserProfile userProfile, String email) {
    final List<UserProfile> userProfileList = [];
    for (var userProfile in userProfileList) {
      if (userProfile.email != email) {
        return true;
      }
    }
    return false;
  }
}