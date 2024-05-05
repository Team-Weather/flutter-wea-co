import 'package:weaco/domain/weather/model/weather.dart';

abstract interface class WeatherRepository {
  Future<Weather?> getWeather();
}
