import 'package:weaco/data/user/data_source/remote_user_profile_data_source.dart';
import 'package:weaco/data/user/data_source/user_auth_data_source.dart';
import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_auth_repository.dart';

class UserAuthRepositoryImpl implements UserAuthRepository {
  final UserAuthDataSource _userAuthDataSource;
  final RemoteUserProfileDataSource _remoteUserProfileDataSource;

  const UserAuthRepositoryImpl({
    required UserAuthDataSource userAuthDataSource,
    required RemoteUserProfileDataSource remoteUserProfileDataSource,
  })  : _userAuthDataSource = userAuthDataSource,
        _remoteUserProfileDataSource = remoteUserProfileDataSource;

  @override
  Future<bool> signUp({
    required UserAuth userAuth,
    required UserProfile userProfile,
  }) async {
    final signUpResult = await _userAuthDataSource.signUp(
        email: userAuth.email, password: userAuth.password);

    final saveUserProfileResult = await _remoteUserProfileDataSource
        .saveUserProfile(userProfile: userProfile);

    return signUpResult && saveUserProfileResult;
  }

  @override
  Future<bool> signIn({required UserAuth userAuth}) async {
    return await _userAuthDataSource.signIn(
        email: userAuth.email, password: userAuth.password);
  }

  @override
  Future<bool> logOut() async {
    return await _userAuthDataSource.logOut();
  }

  @override
  Future<bool> signOut() async {
    return await _userAuthDataSource.signOut();
  }
}
