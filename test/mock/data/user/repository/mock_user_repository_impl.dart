import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_repository.dart';

class MockUserRepositoryImpl implements UserRepository {
  bool isLoggedOut = false;
  List<String> registeredEmailList = [
    'test1@email.com',
    'test2@email.com',
    'test3@email.com',
  ];
  final List<UserProfile> _userProfileList = [];
  bool isRegisteredReturnValue = false;

  @override
  Future<bool> logOut() async {
    return isLoggedOut;
  }

  void initMockData() {
    isLoggedOut = false;
    isRegisteredReturnValue = false;
  }

  @override
  Future<bool> signUp(
      {required UserAuth userAuth, required UserProfile userProfile}) async {
    for (UserProfile userProfile in _userProfileList) {
      if (userProfile.email == userAuth.email) {
        return false;
      }
    }
    return true;
  }

  @override
  Future<bool> isRegistered({required String email}) async{
    return isRegisteredReturnValue;
  }
}
