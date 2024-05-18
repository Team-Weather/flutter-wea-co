import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class UserProvider {
  String? _email;

  String? get email => _email;

  final UserAuthRepository userAuthRepository;

  UserProvider({required this.userAuthRepository}) {
    _email = userAuthRepository.signInCheck();
  }

  void signIn({required String email}) {
    _email = email;
  }

  void signOut() {
    _email = null;
  }
}
