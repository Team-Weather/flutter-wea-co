import 'package:weaco/core/enum/season_code.dart';
import 'package:weaco/data/weather/dto/weather_dto.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';

extension DailyLocationWeatherMapper on WeatherDto {
  DailyLocationWeather toDailyLocationWeather({required Location location}) {
    DateTime now = DateTime.now();
    int length = (hourly?.temperature2m?.length ?? 0) ~/ 2;
    double unknownTemperature = -99.0;
    int unknownCode = -99;

    return DailyLocationWeather(
        seasonCode: SeasonCode.fromMonth(now.month).value,
        highTemperature:
            daily?.temperature2mMax?.last.toDouble() ?? unknownTemperature,
        lowTemperature:
            daily?.temperature2mMin?.last.toDouble() ?? unknownTemperature,
        weatherList: List.generate(
          length,
          (index) {
            final hour = index + 24;
            return Weather(
              temperature: hourly?.temperature2m?.elementAt(hour).toDouble() ??
                  unknownTemperature,
              timeTemperature:
                  DateTime.tryParse(hourly?.time?.elementAt(hour) ?? '') ?? now,
              code: hourly?.weathercode?.elementAt(hour).toInt() ?? unknownCode,
              createdAt: now,
            );
          },
        ),
        yesterDayWeatherList: List.generate(length, (index) {
          return Weather(
            temperature: hourly?.temperature2m?.elementAt(index).toDouble() ??
                unknownTemperature,
            timeTemperature:
                DateTime.tryParse(hourly?.time?.elementAt(index) ?? '') ?? now,
            code: hourly?.weathercode?.elementAt(index).toInt() ?? unknownCode,
            createdAt: now,
          );
        }),
        location: location,
        createdAt: now);
  }
}
