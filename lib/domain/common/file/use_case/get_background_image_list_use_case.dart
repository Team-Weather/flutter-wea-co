import 'package:weaco/domain/common/file/repository/file_repository.dart';
import 'package:weaco/domain/weather/model/weather_background_image.dart';

class GetBackgroundImageListUseCase {
  final FileRepository _fileRepository;

  GetBackgroundImageListUseCase({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  /// 날씨 화면의 배경 이미지를 가져오기 위한 Use Case
  Future<List<WeatherBackgroundImage>> execute() async {
    return await _fileRepository.getWeatherBackgroundImageList();
  }
}
