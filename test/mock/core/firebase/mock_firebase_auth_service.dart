import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:weaco/core/firebase/firebase_auth_service.dart';

class MockFirebaseAuthService implements FirebaseAuthService {
  final user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: 'bob@somedomain.com',
    displayName: 'Bob',
  );

  MockFirebaseAuth _mockAuth = MockFirebaseAuth();
  UserCredential? _userCredential;
  FirebaseAuthService? firebaseAuthService;

  @override
  FirebaseAuth get firebaseAuth => _mockAuth;

  @override
  UserCredential? get userCredential => _userCredential;

  void initMockData() async {
    _mockAuth = MockFirebaseAuth(mockUser: user, signedIn: true);
    _userCredential = await _mockAuth.createUserWithEmailAndPassword(
        email: 'bob@somedomain.com', password: 'password');
  }

  // 회원가입
  @override
  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _mockAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on Exception catch (e) {
      log(e.toString(), name: 'FirebaseService.signUp()');
      rethrow;
    }
  }

  // 로그인
  @override
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _mockAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception catch (e) {
      log(e.toString(), name: 'FirebaseService.signIn()');
      rethrow;
    }
  }

  // 로그아웃
  @override
  Future<void> logOut() async {
    try {
      await _mockAuth.signOut();
    } on Exception catch (e) {
      log(e.toString(), name: 'FirebaseService.logOut()');
      rethrow;
    }
  }

  // 회원탈퇴
  @override
  Future<void> signOut() async {
    try {
      await _mockAuth.currentUser!.delete();
    } on Exception catch (e) {
      log(e.toString(), name: 'FirebaseService.signOut()');
      rethrow;
    }
  }
}
