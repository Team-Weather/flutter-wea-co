import 'package:weaco/data/weather/data_source/remote_data_source/remote_weather_background_image_data_source.dart';
import 'package:weaco/domain/weather/model/weather_background_image.dart';
import 'package:weaco/domain/weather/repository/weather_background_image_repository.dart';

class WeatherBackgroundImageRepositoryImpl
    implements WeatherBackgroundImageRepository {
  final RemoteWeatherBackgroundImageDataSource _remoteDataSource;

  WeatherBackgroundImageRepositoryImpl(
      {required RemoteWeatherBackgroundImageDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<List<WeatherBackgroundImage>> getWeatherBackgroundImageList() async {
    return await _remoteDataSource.getWeatherBackgroundImageList();
  }
}
