import 'package:weaco/domain/user/repository/user_repository.dart';

class MockUserRepositoryImpl implements UserRepository {
  bool isLoggedOut = false;

  @override
  Future<bool> logOut() async {
    return isLoggedOut;
  }

  void initMockData() {
    isLoggedOut = false;
  }
}
