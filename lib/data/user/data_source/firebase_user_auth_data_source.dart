import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:weaco/core/firebase/firebase_service.dart';
import 'package:weaco/data/user/data_source/user_auth_data_source.dart';

class FirebaseUserAuthDataSourceImpl implements UserAuthDataSource {
  final FirebaseService _firebaseService;

  const FirebaseUserAuthDataSourceImpl({
    required FirebaseService firebaseService,
  }) : _firebaseService = firebaseService;

  // 회원가입
  @override
  Future<bool> signUp({required String email, required String password}) async {
    final UserCredential? userCredential;
    bool isSignUpSuccess = false;

    try {
      userCredential =
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
    bool isSignInSuccess = false;

    try {
      _firebaseService.firebaseAuth.userChanges().listen((User? user) {
        if (user != null) {
          isSignInSuccess = true;
        }
      });

      await _firebaseService.signIn(email: email, password: password);
    } on Exception catch (e) {
      isSignInSuccess = false;
      log(e.toString(), name: 'FirebaseUserAuthDataSource.signIn()');
      rethrow;
    }

    return isSignInSuccess;
  }

  // 로그아웃
  @override
  Future<bool> logOut() async {
    bool isLogOutSuccess = false;

    try {
      _firebaseService.firebaseAuth.userChanges().listen((User? user) {
        if (user == null) {
          isLogOutSuccess = true;
        }
      });
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
    bool isSignOutSuccess = false;

    try {
      await _firebaseService.signOut();

      isSignOutSuccess = true;
    } on Exception catch (e) {
      isSignOutSuccess = false;
      log(e.toString(), name: 'FirebaseUserAuthDataSource.signOut()');
      rethrow;
    }

    return isSignOutSuccess;
  }
}
