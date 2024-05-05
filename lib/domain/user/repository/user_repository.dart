import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/model/user_profile.dart';

abstract interface class UserRepository {
  Future<bool> signUp(UserAuth userAuth, UserProfile userProfile, String email);
}
