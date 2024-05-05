import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class SignInUserUseCase {
  final UserAuthRepository _userAuthRepository;

  const SignInUserUseCase({
    required UserAuthRepository userAuthRepository,
  }) : _userAuthRepository = userAuthRepository;

  /// 로그인
  Future<bool> execute({required UserAuth userAuth}) async {
    return await _userAuthRepository.signIn(userAuth: userAuth);
  }
}
