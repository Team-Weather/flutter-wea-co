import 'package:weaco/domain/user/repository/user_repository.dart';

class LogOutSettingUseCase {
  final UserRepository _userRepository;

  LogOutSettingUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<bool> execute() async {
    return await _userRepository.logOut();
  }
}
