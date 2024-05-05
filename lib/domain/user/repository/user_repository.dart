import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/model/user_profile.dart';

abstract interface class UserRepository {
  Future<bool> signUp({required UserAuth userAuth, required UserProfile
  userProfile});

  Future<bool> isRegistered({required String email});

  Future<bool> logOut();
}