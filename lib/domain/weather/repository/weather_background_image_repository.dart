import 'package:weaco/domain/weather/model/weather_background_image.dart';

abstract interface class WeatherBackgroundImageRepository {
  Future<List<WeatherBackgroundImage>> getWeatherBackgroundImageList();
}