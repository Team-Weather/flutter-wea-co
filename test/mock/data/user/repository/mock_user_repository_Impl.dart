import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_repository.dart';

class MockUserRepositoryImpl implements UserRepository {
  final List<UserProfile> _userProfileList = [];

    List<String> registeredEmailList = [
      'test1@email.com',
      'test2@email.com',
      'test3@email.com',
    ];

  @override
  Future<bool> signUp(
      UserAuth userAuth, UserProfile userProfile, String email) async {
    for (UserProfile userProfile in _userProfileList) {
      if (userProfile.email == email) {
        return false;
      }
    }
    return true;
  }
}
