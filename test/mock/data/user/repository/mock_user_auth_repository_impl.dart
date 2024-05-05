import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class MockUserAuthRepositoryImpl implements UserAuthRepository {
  int signInCallCount = 0;
  UserAuth? methodParameter;

  final List<UserAuth> _fakeUserList = [];

  void initMockData() {
    signInCallCount = 0;
    methodParameter = null;
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
  Future<bool> signOutSetting({required String email}) {
    // TODO: implement signOutSetting
    throw UnimplementedError();
  }
}
