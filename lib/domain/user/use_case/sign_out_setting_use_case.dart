import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class SignOutSettingUseCase {
  final UserAuthRepository _userAuthRepository;

  SignOutSettingUseCase({
    required UserAuthRepository userAuthRepository,
  }) : _userAuthRepository = userAuthRepository;

  /// 설정 화면의 회월 탈퇴를 위한 Use Case
  Future<bool> execute({required String email}) async {
    return await _userAuthRepository.signOutSetting(email: email);
  }
}
