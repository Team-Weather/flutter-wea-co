abstract interface class UserAuthDataSource {
  // 회원가입
  Future<bool> signUp({
    required String email,
    required String password,
  });

  // 로그인
  Future<bool> signIn({
    required String email,
    required String password,
  });

  // 로그아웃
  Future<bool> logOut();

  // 회원탈퇴
  Future<bool> signOut();

  // 로그인 체크 email 반환
  String? signInCheck();
}
