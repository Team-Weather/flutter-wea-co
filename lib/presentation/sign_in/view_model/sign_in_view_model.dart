import 'package:flutter/cupertino.dart';
import 'package:weaco/core/exception/custom_business_exception.dart';
import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/use_case/sign_in_use_case.dart';
import 'package:weaco/presentation/common/enum/exception_alert.dart';
import 'package:weaco/presentation/common/state/exception_state.dart';

class SignInViewModel extends ChangeNotifier {
  final SignInUseCase _signInUseCase;
  ExceptionState? exceptionState;

  SignInViewModel({
    required SignInUseCase signInUseCase,
  }) : _signInUseCase = signInUseCase;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _signInUseCase.execute(
          userAuth: UserAuth(email: email, password: password));
    } on CustomBusinessException catch (e) {
      exceptionState = ExceptionState(
          message: e.message, exceptionAlert: ExceptionAlert.dialog);

      rethrow;
    } catch (e) {
      exceptionState = ExceptionState(
          message: e.toString(), exceptionAlert: ExceptionAlert.snackBar);

      rethrow;
    }
  }

  void clearExceptionState() {
    exceptionState = null;
  }
}
