import 'package:weaco/domain/common/repository/image_repository.dart';

class MockImageRepositoryImpl implements ImageRepository {
  @override
  Future<bool> saveCroppedImage({required List<int> data}) {
    return Future.value(true);
  }
}
