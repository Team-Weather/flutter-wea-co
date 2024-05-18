import 'dart:developer';

import 'package:weaco/core/firebase/firebase_auth_service.dart';
import 'package:weaco/data/user/data_source/user_auth_data_source.dart';

class FirebaseUserAuthDataSourceImpl implements UserAuthDataSource {
  final FirebaseAuthService _firebaseService;

  const FirebaseUserAuthDataSourceImpl({
    required FirebaseAuthService firebaseService,
  }) : _firebaseService = firebaseService;

  // 회원가입
  @override
  Future<bool> signUp({required String email, required String password}) async {
    bool isSignUpSuccess = false;

    try {
      final userCredential =
          await _firebaseService.signUp(email: email, password: password);

      isSignUpSuccess = userCredential?.user != null;
    } on Exception catch (e) {
      isSignUpSuccess = false;
      log(e.toString(), name: 'FirebaseUserAuthDataSource.signUp()');
      rethrow;
    }

    return isSignUpSuccess;
  }

  // 로그인
  @override
  Future<bool> signIn({required String email, required String password}) async {
    try {
      await _firebaseService.signIn(email: email, password: password);
    } on Exception catch (e) {
      log(e.toString(), name: 'FirebaseUserAuthDataSource.signIn()');
      rethrow;
    }

    return true;
  }

  // 로그아웃
  @override
  Future<bool> logOut() async {
    bool isLogOutSuccess = true;

    try {
      await _firebaseService.logOut();
    } on Exception catch (e) {
      isLogOutSuccess = false;
      log(e.toString(), name: 'FirebaseUserAuthDataSource.logOut()');
      rethrow;
    }

    return isLogOutSuccess;
  }

  // 회원탈퇴
  @override
  Future<bool> signOut() async {
    bool isSignOutSuccess = true;

    try {
      await _firebaseService.signOut();
    } on Exception catch (e) {
      isSignOutSuccess = false;
      log(e.toString(), name: 'FirebaseUserAuthDataSource.signOut()');
      rethrow;
    }

    return isSignOutSuccess;
  }

  @override
  String? signInCheck() {
    return _firebaseService.user?.email;
  }
}
