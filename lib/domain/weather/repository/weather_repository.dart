import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';

abstract interface class WeatherRepository {
  Future<DailyLocationWeather?> getDailyLocationWeather({
    required DateTime today,
    required Location location,
  });
}
