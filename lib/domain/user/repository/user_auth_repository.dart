import 'package:weaco/domain/user/model/user_auth.dart';

import '../model/user_profile.dart';

abstract interface class UserAuthRepository {
  Future<bool> signIn({required UserAuth userAuth});

  Future<bool> signUp({
    required UserAuth userAuth,
    required UserProfile userProfile,
  });

  Future<bool> isRegistered({required String email});

  Future<bool> signOut();

  Future<bool> logOut();
}
