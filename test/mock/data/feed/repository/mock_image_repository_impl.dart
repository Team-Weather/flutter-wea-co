import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/common/repository/image_repository.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

class MockImageRepositoryImpl implements ImageRepository {
  @override
  Future<Feed> saveCroppedImage(String imagePath) async {
    return Feed(
      id: '1',
      imagePath: 'imagePath',
      userEmail: 'test@email.com',
      description: 'description',
      weather: Weather(
        temperature: 1.0,
        timeTemperature: DateTime.now(),
        code: 1,
        createdAt: DateTime.now(),
      ),
      seasonCode: 1,
      location: Location(
        lat: 1.0,
        lng: 1.0,
        city: '서울시, 노원구',
        createdAt: DateTime.now(),
      ),
      createdAt: DateTime.now(),
    );
  }
}
