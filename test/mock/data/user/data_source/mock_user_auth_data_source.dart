import 'package:weaco/data/user/data_source/user_auth_data_source.dart';

class MockUserAuthDataSourceImpl implements UserAuthDataSource {
  int logOutCallCount = 0;
  int signInCallCount = 0;
  int signOutCallCount = 0;
  int signUpCallCount = 0;
  int signInCheckCallCount = 0;
  String? signInCheckReturnValue;

  Map<String, dynamic> methodParameter = {};

  bool returnValue = false;

  void initMockData() {
    logOutCallCount = 0;
    signInCallCount = 0;
    signOutCallCount = 0;
    signUpCallCount = 0;
    signInCheckCallCount = 0;
    methodParameter.clear();
    returnValue = false;
    signInCheckReturnValue = null;
  }

  @override
  Future<bool> signUp({required String email, required String password}) {
    signUpCallCount++;
    methodParameter = {
      'email': email,
      'password': password,
    };

    return Future.value(returnValue);
  }

  @override
  Future<bool> signIn({required String email, required String password}) {
    signInCallCount++;
    methodParameter = {
      'email': email,
      'password': password,
    };

    return Future.value(returnValue);
  }

  @override
  Future<bool> logOut() {
    logOutCallCount++;
    return Future.value(returnValue);
  }

  @override
  Future<bool> signOut() {
    signOutCallCount++;
    return Future.value(returnValue);
  }

  @override
  String? signInCheck() {
    signInCheckCallCount++;
    return signInCheckReturnValue;
  }
}
