import 'package:flutter/material.dart';
import 'package:weaco/domain/user/use_case/log_out_use_case.dart';
import 'package:weaco/domain/user/use_case/sign_out_use_case.dart';

class AppSettingViewModel with ChangeNotifier {
  final LogOutUseCase _logOutUseCase;
  final SignOutUseCase _signOutUseCase;

  AppSettingViewModel({
    required LogOutUseCase logOutUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _logOutUseCase = logOutUseCase,
        _signOutUseCase = signOutUseCase;

  bool _isLogOuting = true;

  bool get isLogOuting => _isLogOuting;

  /// 로그아웃 성공 시, true 반환
  Future<bool> logOut() async {
    _isLogOuting = true;
    notifyListeners();
    try {
      await _logOutUseCase.execute();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 회원탈퇴 성공 시, true 반환
  Future<bool> signOut() async {
    try {
      await _signOutUseCase.execute();
      return true;
    } catch (e) {
      return false;
    }
  }
}
