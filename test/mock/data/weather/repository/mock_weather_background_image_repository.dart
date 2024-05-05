import 'package:weaco/domain/weather/model/weather_background_image.dart';
import 'package:weaco/domain/weather/repository/weather_background_image_repository.dart';

class MockWeatherBackgroundImageRepository
    implements WeatherBackgroundImageRepository {
  int getWeatherBackgroundImageListCallCount = 0;
  List<WeatherBackgroundImage> getWeatherBackgroundImageListResult = [];

  void initMockData() {
    getWeatherBackgroundImageListCallCount = 0;
    getWeatherBackgroundImageListResult = [];
  }

  @override
  Future<List<WeatherBackgroundImage>> getWeatherBackgroundImageList() async {
    getWeatherBackgroundImageListCallCount++;
    return getWeatherBackgroundImageListResult;
  }
}
