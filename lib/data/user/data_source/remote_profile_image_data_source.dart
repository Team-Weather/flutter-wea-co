import 'package:weaco/domain/common/file/model/profile_image.dart';

abstract interface class RemoteProfileImageDataSource {
  Future<List<ProfileImage>> getProfileImageList();
}
