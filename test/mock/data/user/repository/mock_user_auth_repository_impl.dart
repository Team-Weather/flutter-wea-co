import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class MockUserAuthRepositoryImpl implements UserAuthRepository {
  int signInCallCount = 0;
  UserAuth? methodParameter;
  bool? returnValue;

  void initMockData() {
    signInCallCount = 0;
    methodParameter = null;
    returnValue = null;
  }

  @override
  Future<bool> signIn({required UserAuth userAuth}) {
    signInCallCount++;
    methodParameter = userAuth;
    return Future.value(returnValue);
  }

  @override
  Future<bool> signOutSetting({required String email}) {
    // TODO: implement signOutSetting
    throw UnimplementedError();
  }
}
