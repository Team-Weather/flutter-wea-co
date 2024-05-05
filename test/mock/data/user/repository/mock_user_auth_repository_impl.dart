import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class MockUserAuthRepositoryImpl implements UserAuthRepository {
  int signInCallCount = 0;
  int signUpCallCount = 0;
  int isRegisteredCallCount = 0;
  int signOutCallCount = 0;
  int logOutCallCount = 0;
  UserAuth? methodParameter;
  bool isSignUp = false;
  bool isRegisteredResult = false;
  bool isSignOut = false;
  bool isLogOut = false;

  final List<UserAuth> _fakeUserList = [];

  void initMockData() {
    signInCallCount = 0;
    signUpCallCount = 0;
    isRegisteredCallCount = 0;
    signOutCallCount = 0;
    logOutCallCount = 0;
    methodParameter = null;
    isSignUp = false;
    isRegisteredResult = false;
    isSignOut = false;
    isLogOut = false;
    _fakeUserList.clear();
  }

  void addUserAuth(UserAuth userAuth) {
    _fakeUserList.add(userAuth);
  }

  @override
  Future<bool> signIn({required UserAuth userAuth}) async {
    signInCallCount++;
    methodParameter = userAuth;
    return _fakeUserList.any(
        (e) => e.email == userAuth.email && e.password == userAuth.password);
  }

  @override
  Future<bool> signUp({
    required UserAuth userAuth,
    required UserProfile userProfile,
  }) async {
    signUpCallCount++;
    return isSignUp;
  }

  @override
  Future<bool> isRegistered({required String email}) async {
    isRegisteredCallCount++;
    return isRegisteredResult;
  }

  @override
  Future<bool> signOut() async {
    signOutCallCount++;
    return isSignOut;
  }

  @override
  Future<bool> logOut() async {
    logOutCallCount++;
    return isLogOut;
  }
}
