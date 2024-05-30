import 'package:weaco/domain/common/extension/list.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

class DailyLocationWeather {
  final double highTemperature;
  final double lowTemperature;
  final List<Weather> weatherList;
  final List<Weather> yesterDayWeatherList;
  final List<Weather> tomorrowWeatherList;
  final Location location;
  final DateTime createdAt;
  final int seasonCode;

  const DailyLocationWeather({
    required this.highTemperature,
    required this.lowTemperature,
    required this.weatherList,
    required this.yesterDayWeatherList,
    required this.tomorrowWeatherList,
    required this.location,
    required this.createdAt,
    required this.seasonCode,
  });

  @override
  String toString() {
    return 'DailyLocationWeather{highTemperature: $highTemperature, lowTemperature: $lowTemperature, weatherList: $weatherList, yesterDayWeatherList: $yesterDayWeatherList, tomorrowWeatherList: $tomorrowWeatherList, location: $location, createdAt: $createdAt, seasonCode: $seasonCode}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyLocationWeather &&
          runtimeType == other.runtimeType &&
          highTemperature == other.highTemperature &&
          lowTemperature == other.lowTemperature &&
          weatherList.equals(other.weatherList) &&
          yesterDayWeatherList.equals(other.yesterDayWeatherList) &&
          tomorrowWeatherList.equals(other.tomorrowWeatherList) &&
          location == other.location &&
          createdAt == other.createdAt &&
          seasonCode == other.seasonCode;

  @override
  int get hashCode =>
      highTemperature.hashCode ^
      lowTemperature.hashCode ^
      weatherList.fold(1, (prev, next) => prev.hashCode ^ next.hashCode) ^
      yesterDayWeatherList.fold(
          1, (prev, next) => prev.hashCode ^ next.hashCode) ^
      tomorrowWeatherList.fold(
          1, (prev, next) => prev.hashCode ^ next.hashCode) ^
      location.hashCode ^
      createdAt.hashCode ^
      seasonCode.hashCode;

  DailyLocationWeather copyWith({
    double? highTemperature,
    double? lowTemperature,
    List<Weather>? weatherList,
    List<Weather>? yesterDayWeatherList,
    List<Weather>? tomorrowWeatherList,
    Location? location,
    DateTime? createdAt,
    int? seasonCode,
  }) {
    return DailyLocationWeather(
      highTemperature: highTemperature ?? this.highTemperature,
      lowTemperature: lowTemperature ?? this.lowTemperature,
      weatherList: weatherList ?? this.weatherList,
      yesterDayWeatherList: yesterDayWeatherList ?? this.yesterDayWeatherList,
      tomorrowWeatherList: tomorrowWeatherList ?? this.tomorrowWeatherList,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      seasonCode: seasonCode ?? this.seasonCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'high_temperature': highTemperature,
      'low_temperature': lowTemperature,
      'weather_list': weatherList.map((weather) => weather.toJson()).toList(),
      'yesterday_weather_list':
          yesterDayWeatherList.map((weather) => weather.toJson()).toList(),
      'tomorrow_weather_list':
          tomorrowWeatherList.map((weather) => weather.toJson()).toList(),
      'location': location.toJson(),
      'created_at': createdAt.toIso8601String(),
      'season_code': seasonCode,
    };
  }

  factory DailyLocationWeather.fromJson(Map<String, dynamic> json) {
    return DailyLocationWeather(
      highTemperature: json['high_temperature'] as double,
      lowTemperature: json['low_temperature'] as double,
      weatherList: (json['weather_list'] as List)
          .map((e) => Weather.fromJson(e))
          .toList(),
      yesterDayWeatherList: (json['yesterday_weather_list'] as List)
          .map((e) => Weather.fromJson(e))
          .toList(),
      tomorrowWeatherList: (json['tomorrow_weather_list'] as List)
          .map((e) => Weather.fromJson(e))
          .toList(),
      location: Location.fromJson(json['location']),
      createdAt: DateTime.parse(json['created_at']),
      seasonCode: json['season_code'] as int,
    );
  }
}
