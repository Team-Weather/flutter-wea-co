import 'package:firebase_core/firebase_core.dart';
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
      String? message;
      print('signIn ex bool ${e is FirebaseException}');
      if (e is FirebaseException) {
        print('ex code ${e.code}');
        message = switch (e.code) {
          'user-not-found' => '존재하지 않는 유저입니다.',
          'wrong-password' => '비밀번호가 맞지 않습니다.',
          'email-already-in-use' => '이미 가입된 이메일입니다.',
          'invalid-email' => '이메일 형식이 올바르지 못합니다.',
          'operation-not-allowed' => '허용되지 않는 요청입니다.',
          'weak-password' => '비밀번호 형식이 안전하지 않습니다.',
          'network-request-failed' => '네트워크가 불안정 합니다.',
          'too-many-requests' => '요청이 너무 많습니다.',
          'user-disabled' => '이미 탈퇴한 회원입니다.',
          'invalid-credential' => '이메일과 비밀번호를 확인해주세요.',
          _ => null,
        };
      }

      exceptionState = ExceptionState(
          message: message ?? '로그인에 실패 하였습니다.',
          exceptionAlert: ExceptionAlert.snackBar);

      rethrow;
    }
  }

  void clearExceptionState() {
    exceptionState = null;
  }
}
