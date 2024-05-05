import 'package:weaco/domain/user/model/user_auth.dart';

abstract interface class UserAuthRepository {
  Future<bool> signOutSetting({required String email});

  Future<bool> signIn({required UserAuth userAuth});
}
