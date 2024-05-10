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

  /// 사용자 Auth 정보와 Profile 정보로 회원가입 한 후 결과를 반환하는 메소드
  ///
  /// UserAuthDataSource.signUp() 메소드를 호출하여 유저 계정을 생성한다.
  /// 실패 시, return false
  ///
  /// 성공했을 경우, RemoteUserProfileDataSource.saveUserProfile()
  /// 메소드를 호출하여 유저 프로파일 정보를 저장한다.
  /// 실패 시,  UserAuthDataSource.signUp() 로 등록했던 유저계정을
  /// UserAuthDataSource.signOut() 를 호출하여 계정을 삭제 한 후 return false.
  ///
  /// 두 작업이 완료시 return true
  @override
  Future<bool> signUp({
    required UserAuth userAuth,
    required UserProfile userProfile,
  }) async {
    final signUpResult = await _userAuthDataSource.signUp(
        email: userAuth.email, password: userAuth.password);

    if (signUpResult == false) {
      return false;
    }

    final saveUserProfileResult = await _remoteUserProfileDataSource
        .saveUserProfile(userProfile: userProfile);

    if (saveUserProfileResult == false) {
      await _userAuthDataSource.signOut();
      return false;
    }

    return true;
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
