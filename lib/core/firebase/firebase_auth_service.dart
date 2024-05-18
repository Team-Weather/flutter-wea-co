import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential? _userCredential;
  User? _user;

  User? get user => _user;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  UserCredential? get userCredential => _userCredential;

  FirebaseAuthService() {
    _addAuthStateChangesListener();
  }

  // 회원가입
  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return _userCredential;
    } on Exception catch (e) {
      log(e.toString(), name: 'FirebaseService.signUp()');
      rethrow;
    }
  }

  // 로그인
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return _userCredential;
    } on Exception catch (e) {
      log(e.toString(), name: 'FirebaseService.signIn()');
      rethrow;
    }
  }

  // 로그아웃
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception catch (e) {
      log(e.toString(), name: 'FirebaseService.logOut()');
      rethrow;
    }
  }

  // 회원탈퇴
  Future<void> signOut() async {
    try {
      await _userCredential?.user?.delete();
    } on Exception catch (e) {
      log(e.toString(), name: 'FirebaseService.signOut()');
      rethrow;
    }
  }

  void _addAuthStateChangesListener() {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user == null) {
        _user = null;
        _userCredential = null;
      } else {
        _user = user;
      }
    });
  }
}
