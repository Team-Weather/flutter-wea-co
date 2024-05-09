import 'package:weaco/data/user/data_source/remote_profile_image_data_source.dart';
import 'package:weaco/domain/user/model/profile_image.dart';
import 'package:weaco/domain/user/repository/profile_image_repository.dart';

class ProfileImageRepositoryImpl implements ProfileImageRepository {
  final RemoteProfileImageDataSource _remoteDataSource;

  ProfileImageRepositoryImpl(
      {required RemoteProfileImageDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<List<ProfileImage>> getProfileImageList() async {
    return await _remoteDataSource.getProfileImageList();
  }
}
