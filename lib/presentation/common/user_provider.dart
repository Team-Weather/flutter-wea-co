import 'package:flutter/material.dart';
import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class UserProvider extends ChangeNotifier {
  String? _email;

  String? get email => _email;

  final UserAuthRepository userAuthRepository;

  UserProvider({required this.userAuthRepository}) {
    _email = userAuthRepository.signInCheck();
    notifyListeners();
  }

  void signIn({required String email}) {
    _email = email;
    notifyListeners();
  }

  void signOut() {
    _email = null;
    notifyListeners();
  }
}
