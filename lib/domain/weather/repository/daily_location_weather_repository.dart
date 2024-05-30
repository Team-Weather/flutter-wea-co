import 'package:weaco/domain/weather/model/daily_location_weather.dart';

abstract interface class DailyLocationWeatherRepository {
  Future<DailyLocationWeather> getDailyLocationWeather();
}
