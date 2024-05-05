import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/repository/daily_location_weather_repository.dart';

/// 홈 화면에서 날씨 정보를 보여주기 위한 Use Case
class GetDailyLocationWeatherUseCase {
  final DailyLocationWeatherRepository _dailyLocationWeatherRepository;

  GetDailyLocationWeatherUseCase(
      {required DailyLocationWeatherRepository dailyLocationWeatherRepository})
      : _dailyLocationWeatherRepository = dailyLocationWeatherRepository;

  Future<DailyLocationWeather> execute({
    required DateTime date,
    required Location location,
  }) async {
    try {
      return await _dailyLocationWeatherRepository.getDailyLocationWeather(
        date: date,
        location: location,
      );
    } catch (e) {
      Exception(e);
    }

    return DailyLocationWeather(
      highTemperature: -1,
      lowTemperature: -1,
      weatherList: [],
      location: location,
      createdAt: DateTime.now(),
    );
  }
}
