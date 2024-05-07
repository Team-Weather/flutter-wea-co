import 'package:weaco/domain/weather/model/daily_location_weather.dart';

abstract interface class RemoteDailyLocationWeatherDataSource {
  Future<DailyLocationWeather?> getRemoteDailyLocationWeather();
}
