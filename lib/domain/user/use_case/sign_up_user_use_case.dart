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
  Future<bool> execute(
      {required UserAuth userAuth, required UserProfile userProfile}) async {
    // email을 중복 검사 한다.
    // 중복된 email이 있으면 exception을 발생시킨다.
    // 중복된 email이 없으면 회원 가입을 진행한다.
    if (await _userRepository.isRegistered(email: userAuth.email)) {
      return false;
    }
    return await _userRepository.signUp(
        userAuth: userAuth, userProfile: userProfile);
  }
}
