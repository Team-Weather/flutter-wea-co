import 'package:weaco/domain/user/model/profile_image.dart';
import 'package:weaco/domain/user/repository/profile_image_repository.dart';

class GetProfileImageListUseCase {
  final ProfileImageRepository _profileImageRepository;

  GetProfileImageListUseCase(
      {required ProfileImageRepository profileImageRepository})
      : _profileImageRepository = profileImageRepository;

  Future<List<ProfileImage>> execute() async {
    return await _profileImageRepository.getProfileImageList();
  }
}
