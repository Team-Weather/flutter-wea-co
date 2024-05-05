import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/common/repository/image_repository.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

class MockImageRepositoryImpl implements ImageRepository {
  @override
  Future<bool> saveCroppedImage({required List<int> data}) {
    return Future.value(true);
  }
}
