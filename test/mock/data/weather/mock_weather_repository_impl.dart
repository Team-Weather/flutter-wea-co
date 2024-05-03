import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/repository/weather_repository.dart';

class MockDailyWeatherRepositoryImpl implements WeatherRepository {
  // 메서드 호출시 인자 확인을 위한 map
  final Map<String, dynamic> methodParameterMap = {};
  int dailyLocationWeatherCallCount = 0;
  DailyLocationWeather? dailyLocationWeatherResult;

  void initMockData() {
    dailyLocationWeatherCallCount = 0;
    dailyLocationWeatherResult = null;
  }

  /// [_dailyLocationWeather] 반환, 정보가 없을 경우 null 반환
  /// 호출시 [dailyLocationWeatherCallCount] + 1
  @override
  Future<DailyLocationWeather?> getDailyLocationWeather({
    required DateTime today,
    required Location location,
  }) {
    dailyLocationWeatherCallCount++;
    methodParameterMap['today'] = today;
    methodParameterMap['location'] = location;

    return Future.value(dailyLocationWeatherResult);
  }

  void addDailyLocationWeather(
      {required DailyLocationWeather dailyLocationWeather}) {
    dailyLocationWeatherResult = dailyLocationWeather;
  }
}
