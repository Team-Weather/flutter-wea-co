import 'package:weaco/data/weather/data_source/local_data_source/local_daily_location_weather_data_source.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';

class MockLocalDailyLocationWeatherDataSourceImpl
    implements LocalDailyLocationWeatherDataSource {
  int getLocalDailyLocationWeatherCallCount = 0;
  int saveLocalDailyLocationWeatherCallCount = 0;
  DailyLocationWeather? getLocalDailyLocationWeatherResult;
  DailyLocationWeather? saveLocalDailyLocationWeatherParameter;

  void initMockData() {
    getLocalDailyLocationWeatherCallCount = 0;
    saveLocalDailyLocationWeatherCallCount = 0;
    getLocalDailyLocationWeatherResult = null;
    saveLocalDailyLocationWeatherParameter = null;
  }

  @override
  Future<DailyLocationWeather?> getLocalDailyLocationWeather() async {
    getLocalDailyLocationWeatherCallCount++;

    return getLocalDailyLocationWeatherResult;
  }

  @override
  Future<void> saveLocalDailyLocationWeather(
      {required DailyLocationWeather dailyLocationWeather}) async {
    saveLocalDailyLocationWeatherCallCount++;
    saveLocalDailyLocationWeatherParameter = dailyLocationWeather;
  }
}
