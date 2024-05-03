import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/repository/weather_repository.dart';

/// 홈 화면에서 날씨 정보를 보여주기 위한 Use Case
class GetHomeWeatherUseCase {
  final WeatherRepository _weatherRepository;

  GetHomeWeatherUseCase({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository;

  Future<DailyLocationWeather?> execute({
    required DateTime date,
    required Location location,
  }) async {
    DailyLocationWeather? dailyLocationWeather;

    try {
      dailyLocationWeather = await _weatherRepository.getDailyLocationWeather(
        today: date,
        location: location,
      );
    } catch (e) {
      Exception(e);
    }

    return dailyLocationWeather;
  }
}
