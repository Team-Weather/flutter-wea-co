import 'package:weaco/domain/weather/model/weather_background_image.dart';
import 'package:weaco/domain/weather/repository/weather_background_image_repository.dart';

class GetBackgroundImageListUseCase {
  final WeatherBackgroundImageRepository _weatherBackgroundImageRepository;

  GetBackgroundImageListUseCase(
      {required WeatherBackgroundImageRepository
          weatherBackgroundImageRepository})
      : _weatherBackgroundImageRepository = weatherBackgroundImageRepository;

  /// 날씨 화면의 배경 이미지를 가져오기 위한 Use Case
  Future<List<WeatherBackgroundImage>> execute() async {
    return await _weatherBackgroundImageRepository
        .getWeatherBackgroundImageList();
  }
}
