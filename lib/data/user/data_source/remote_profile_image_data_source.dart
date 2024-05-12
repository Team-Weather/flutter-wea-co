import 'package:weaco/domain/user/model/profile_image.dart';

abstract interface class RemoteProfileImageDataSource {
  Future<List<ProfileImage>> getProfileImageList();
}
