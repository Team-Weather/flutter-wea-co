import 'package:weaco/data/weather/data_soruce/remote_weather_background_image_data_source.dart';
import 'package:weaco/domain/weather/model/weather_background_image.dart';

class MockRemoteWeatherBackgroundImageDataSourceImpl
    implements RemoteWeatherBackgroundImageDataSource {
  int methodCallCount = 0;
  dynamic methodResult;
  final Map<String, dynamic> methodParameter = {};

  void initMockData() {
    methodCallCount = 0;
    methodResult = null;
    methodParameter.clear();
  }

  @override
  Future<List<WeatherBackgroundImage>> getWeatherBackgroundImageList() async {
    methodCallCount++;
    return methodResult;
  }
}
