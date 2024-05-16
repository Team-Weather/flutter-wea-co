import 'package:weaco/core/enum/season_code.dart';
import 'package:weaco/data/weather/dto/weather_dto.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';

extension DailyLocationWeatherMapper on WeatherDto {
  DailyLocationWeather toDailyLocationWeather({required Location location}) {
    final DateTime now = DateTime.now();
    const double unknownTemperature = -99.0;
    const int todayMaxAndMinIndex = 1;
    const int todayIndex = 24;
    const int yesterDayIndex = 0;
    const int tomorrowIndex = 48;

    return DailyLocationWeather(
        seasonCode: SeasonCode.fromMonth(now.month).value,
        highTemperature: daily?.temperature2mMax
                ?.elementAt(todayMaxAndMinIndex)
                .toDouble() ??
            unknownTemperature,
        lowTemperature: daily?.temperature2mMin
                ?.elementAt(todayMaxAndMinIndex)
                .toDouble() ??
            unknownTemperature,
        weatherList: _toWhetherList(todayIndex, now),
        yesterDayWeatherList: _toWhetherList(yesterDayIndex, now),
        tomorrowWeatherList: _toWhetherList(tomorrowIndex, now),
        location: location,
        createdAt: now);
  }

  List<Weather> _toWhetherList(int plusIndex, DateTime now) {
    final int length = (hourly?.temperature2m?.length ?? 0) ~/ 3;
    const double unknownTemperature = -99.0;
    const int unknownCode = -99;

    return List.generate(
      length,
      (index) {
        final i = index + plusIndex;
        return Weather(
          temperature: hourly?.temperature2m?.elementAt(i).toDouble() ??
              unknownTemperature,
          timeTemperature:
              DateTime.tryParse(hourly?.time?.elementAt(i) ?? '') ??
                  DateTime.now(),
          code: hourly?.weathercode?.elementAt(i).toInt() ?? unknownCode,
          createdAt: DateTime.now(),
        );
      },
    );
  }
}
