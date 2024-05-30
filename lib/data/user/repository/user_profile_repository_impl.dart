import 'package:weaco/data/user/data_source/remote_user_profile_data_source.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final RemoteUserProfileDataSource _remoteUserProfileDataSource;

  const UserProfileRepositoryImpl({
    required RemoteUserProfileDataSource remoteUserProfileDataSource,
  }) : _remoteUserProfileDataSource = remoteUserProfileDataSource;

  @override
  Future<UserProfile?> getMyProfile() async {
    return await _remoteUserProfileDataSource.getUserProfile();
  }

  @override
  Future<UserProfile?> getUserProfile({required String email}) async {
    return await _remoteUserProfileDataSource.getUserProfile(email: email);
  }

  @override
  Future<bool> updateUserProfile({required UserProfile userProfile}) async {
    return await _remoteUserProfileDataSource.updateUserProfile(userProfile: userProfile);
  }
}
