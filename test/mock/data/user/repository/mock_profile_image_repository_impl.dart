import 'package:weaco/domain/user/model/profile_image.dart';
import 'package:weaco/domain/user/repository/profile_image_repository.dart';

class MockProfileImageRepositoryImpl implements ProfileImageRepository {
  int getProfileImageListCallCount = 0;
  List<ProfileImage> getProfileImageResult = [];

  void initData() {
    getProfileImageListCallCount = 0;
    getProfileImageResult.clear();
  }

  @override
  Future<List<ProfileImage>> getProfileImageList() async {
    getProfileImageListCallCount++;
    return getProfileImageResult;
  }
}
