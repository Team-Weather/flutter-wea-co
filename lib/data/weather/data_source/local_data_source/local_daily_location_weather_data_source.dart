import 'package:weaco/domain/weather/model/daily_location_weather.dart';

abstract interface class LocalDailyLocationWeatherDataSource {
  Future<void> saveLocalDailyLocationWeather({
    required DailyLocationWeather dailyLocationWeather,
  });

  Future<DailyLocationWeather?> getLocalDailyLocationWeather();
}
