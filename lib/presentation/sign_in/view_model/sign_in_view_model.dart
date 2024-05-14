import 'package:flutter/cupertino.dart';
import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/use_case/sign_in_use_case.dart';

class SignInViewModel extends ChangeNotifier {
  final SignInUseCase _signInUseCase;

  SignInViewModel({
    required SignInUseCase signInUseCase,
  }) : _signInUseCase = signInUseCase;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _signInUseCase.execute(
        userAuth: UserAuth(email: email, password: password));
  }
}
