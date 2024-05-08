import 'package:weaco/data/weather/dto/weather_dto.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';

extension DailyLocationWeatherMapper on WeatherDto {
  DailyLocationWeather toDailyLocationWeather({required Location location}) {
    DateTime now = DateTime.now();
    int length = (hourly?.temperature2m?.length ?? 0) ~/ 2;
    return DailyLocationWeather(
        highTemperature: daily?.temperature2mMax?.last.toDouble() ?? 0.0,
        lowTemperature: daily?.temperature2mMin?.last.toDouble() ?? 0.0,
        weatherList: List.generate(
            length,
            (index) => Weather(
                  temperature:
                      hourly?.temperature2m?.elementAt(index).toDouble() ?? 0.0,
                  timeTemperature:
                      DateTime.parse(hourly?.time?.elementAt(index) ?? ''),
                  code: hourly?.weathercode?.elementAt(index).toInt() ?? 0,
                  createdAt: now,
                )),
        yesterDayWeatherList: List.generate(length, (index) {
          index = index + 24;
          return Weather(
            temperature:
                hourly?.temperature2m?.elementAt(index).toDouble() ?? 0.0,
            timeTemperature:
                DateTime.parse(hourly?.time?.elementAt(index) ?? ''),
            code: hourly?.weathercode?.elementAt(index).toInt() ?? 0,
            createdAt: now,
          );
        }),
        location: location,
        createdAt: now);
  }
}
