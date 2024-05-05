import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import 'package:weaco/domain/weather/repository/weather_repository.dart';

class MockWeatherRepository implements WeatherRepository {
  int getWeatherCallCount = 0;
  Location? methodParameter;
  Weather? returnValue;

  void initMockData() {
    getWeatherCallCount = 0;
    methodParameter = null;
    returnValue = null;
  }

  @override
  Future<Weather?> getWeather({Location? location}) {
    getWeatherCallCount++;
    methodParameter = location;
    return Future.value(returnValue);
  }
}
