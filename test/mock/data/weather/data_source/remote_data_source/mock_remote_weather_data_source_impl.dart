import 'package:weaco/data/weather/data_source/remote_data_source/remote_weather_data_source.dart';
import 'package:weaco/data/weather/dto/weather_dto.dart';

class MockRemoteWeatherDataSourceImpl implements RemoteWeatherDataSource {
  int getWeatherCallCount = 0;
  WeatherDto? getWeatherResult;
  double? getWeatherParameterLat;
  double? getWeatherParameterLng;

  void initMockData() {
    getWeatherCallCount = 0;
    getWeatherResult = null;
    getWeatherParameterLat = null;
    getWeatherParameterLng = null;
  }

  @override
  Future<WeatherDto> getWeather(
      {required double lat, required double lng}) async {
    getWeatherCallCount++;
    getWeatherParameterLat = lat;
    getWeatherParameterLng = lng;

    return getWeatherResult!;
  }
}
