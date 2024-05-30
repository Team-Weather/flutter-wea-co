import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class LogOutUseCase {
  final UserAuthRepository _userAuthRepository;

  LogOutUseCase({
    required UserAuthRepository userAuthRepository,
  }) : _userAuthRepository = userAuthRepository;

  Future<bool> execute() async {
    return await _userAuthRepository.logOut();
  }
}
