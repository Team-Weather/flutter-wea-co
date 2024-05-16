import 'dart:math';

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
      exceptionState = ExceptionState(
          message: e.toString(), exceptionAlert: ExceptionAlert.snackBar);

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
