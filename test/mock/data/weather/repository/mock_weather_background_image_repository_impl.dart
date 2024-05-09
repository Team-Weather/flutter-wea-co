import 'package:weaco/domain/weather/model/weather_background_image.dart';
import 'package:weaco/domain/weather/repository/weather_background_image_repository.dart';

class MockWeatherBackgroundImageRepository
    implements WeatherBackgroundImageRepository {
  int methodCallCount = 0;
  List<WeatherBackgroundImage> getWeatherBackgroundImageListResult = [];

  void initMockData() {
    methodCallCount = 0;
    getWeatherBackgroundImageListResult.clear();
  }

  @override
  Future<List<WeatherBackgroundImage>> getWeatherBackgroundImageList() async {
    methodCallCount++;
    return getWeatherBackgroundImageListResult;
  }
}
