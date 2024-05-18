import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:weaco/core/enum/gender_code.dart';
import 'package:weaco/core/exception/custom_business_exception.dart';
import 'package:weaco/domain/user/model/profile_image.dart';
import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/get_profile_image_list_use_case.dart';
import 'package:weaco/domain/user/use_case/sign_up_use_case.dart';
import 'package:weaco/presentation/common/enum/exception_alert.dart';
import 'package:weaco/presentation/common/state/exception_state.dart';

class SignUpViewModel extends ChangeNotifier {
  final SignUpUseCase _signUpUseCase;
  final GetProfileImageListUseCase _getProfileImagePathUseCase;
  ExceptionState? exceptionState;

  SignUpViewModel(
      {required SignUpUseCase signUpUseCase,
      required GetProfileImageListUseCase getProfileImagePathUseCase})
      : _signUpUseCase = signUpUseCase,
        _getProfileImagePathUseCase = getProfileImagePathUseCase;

  /// 회원가입을 진행한다.
  Future<void> signUp(
      {required String email,
      required String password,
      required String nickname,
      required GenderCode genderCode}) async {
    try {
      await _signUpUseCase.execute(
          userAuth: UserAuth(email: email, password: password),
          userProfile: UserProfile(
              email: email,
              nickname: nickname,
              gender: genderCode.value,
              profileImagePath: await _profileImagePath(),
              feedCount: 0,
              createdAt: DateTime.now()));
    } on CustomBusinessException catch (e) {
      exceptionState = ExceptionState(
          message: e.message, exceptionAlert: ExceptionAlert.dialog);

      rethrow;
    } catch (e) {
      String? message;
      if (e is FirebaseException) {
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
          message: message ?? '회원가입에 실패 하였습니다.',
          exceptionAlert: ExceptionAlert.snackBar);

      rethrow;
    }
  }

  /// 프로필 이미지 경로를 랜덤으로 가져온다.
  Future<String> _profileImagePath() async {
    final List<ProfileImage> imageList =
        await _getProfileImagePathUseCase.execute();

    return imageList[Random().nextInt(imageList.length)].imagePath;
  }
}
