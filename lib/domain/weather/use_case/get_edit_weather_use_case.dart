import 'package:weaco/domain/weather/model/weather.dart';
import 'package:weaco/domain/weather/repository/weather_repository.dart';

class GetEditWeatherUseCase {
  final WeatherRepository _weatherRepository;

  const GetEditWeatherUseCase({
    required WeatherRepository weatherRepository,
  }) : _weatherRepository = weatherRepository;

  Future<Weather?> execute() async {
    return await _weatherRepository.getWeather();
  }
}
