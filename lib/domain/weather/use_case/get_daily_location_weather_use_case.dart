import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/repository/daily_location_weather_repository.dart';

/// 홈 화면에서 날씨 정보를 보여주기 위한 Use Case
class GetDailyLocationWeatherUseCase {
  final DailyLocationWeatherRepository _dailyLocationWeatherRepository;

  GetDailyLocationWeatherUseCase(
      {required DailyLocationWeatherRepository dailyLocationWeatherRepository})
      : _dailyLocationWeatherRepository = dailyLocationWeatherRepository;

  Future<DailyLocationWeather> execute() async {
    return await _dailyLocationWeatherRepository.getDailyLocationWeather();
  }
}
