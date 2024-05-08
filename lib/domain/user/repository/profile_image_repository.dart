import 'package:weaco/domain/common/file/model/profile_image.dart';

abstract interface class ProfileImageRepository {
  Future<List<ProfileImage>> getProfileImageList();
}
