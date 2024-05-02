import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class LogOutSettingUseCase {
  final UserAuthRepository _userAuthRepository;

  LogOutSettingUseCase({
    required UserAuthRepository userAuthRepository,
  }) : _userAuthRepository = userAuthRepository;

  /// 설정 화면의 회월 탈퇴를 위한 Use Case
  Future<bool> execute({required String email}) async {
    return await _userAuthRepository.logOutSetting(email: email);
  }
}
