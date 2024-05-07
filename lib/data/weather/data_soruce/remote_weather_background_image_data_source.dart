import 'package:weaco/domain/weather/model/weather_background_image.dart';

abstract interface class RemoteWeatherBackgroundImageDataSource {
  Future<List<WeatherBackgroundImage>> getWeatherBackgroundImageList();
}
