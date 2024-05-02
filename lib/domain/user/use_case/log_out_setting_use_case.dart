import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class LogOutSettingUseCase {
  final UserAuthRepository _userAuthRepository;

  LogOutSettingUseCase({
    required UserAuthRepository userAuthRepository,
  }) : _userAuthRepository = userAuthRepository;

  Future<bool> execute({required String email}) async {
    return await _userAuthRepository.logOutSetting(email: email);
  }
}
