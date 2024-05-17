import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
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

  PackageInfo? _packageInfo;
  String? _errorMessage;
  bool _isLoading = true;

  String? get errorMessage => _errorMessage;

  bool get isLoading => _isLoading;

  PackageInfo? get packageInfo => _packageInfo;

  bool isLogOuting = true;
  bool isSignOuting = true;

  /// 패키지 정보를 가져오는 메서드
  Future<void> getPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      _packageInfo = info;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 로그아웃 성공 시, true 반환
  Future<bool> logOut() async {
    try {
      await _logOutUseCase.execute();
      isLogOuting = true;
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 회원탈퇴 성공 시, true 반환
  Future<bool> signOut() async {
    try {
      await _signOutUseCase.execute();
      isSignOuting = true;
      return true;
    } catch (e) {
      return false;
    }
  }
}
