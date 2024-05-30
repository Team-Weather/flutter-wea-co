import 'package:weaco/domain/user/model/profile_image.dart';

abstract interface class ProfileImageRepository {
  Future<List<ProfileImage>> getProfileImageList();
}
