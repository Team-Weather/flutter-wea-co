import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential? _userCredential;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  UserCredential? get userCredential => _userCredential;

  // 회원가입
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // 로그인
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // 로그아웃
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  // 회원탈퇴
  Future<void> signOut() async {
    try {
      await _userCredential!.user!.delete();
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
