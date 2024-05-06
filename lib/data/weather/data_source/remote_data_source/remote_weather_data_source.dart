import 'package:weaco/data/weather/dto/weather_dto.dart';

abstract interface class RemoteWeatherDataSource {
  Future<WeatherDto> getWeather({required double lat, required double lng});
}
