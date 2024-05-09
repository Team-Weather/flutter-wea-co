import 'package:weaco/domain/common/extension/list.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

class DailyLocationWeather {
  final double highTemperature;
  final double lowTemperature;
  final List<Weather> weatherList;
  final List<Weather> yesterDayWeatherList;
  final Location location;
  final DateTime createdAt;
  final int seasonCode;

  const DailyLocationWeather({
    required this.highTemperature,
    required this.lowTemperature,
    required this.weatherList,
    required this.yesterDayWeatherList,
    required this.location,
    required this.createdAt,
    required this.seasonCode,
  });

  @override
  String toString() {
    return 'DailyLocationWeather{highTemperature: $highTemperature, lowTemperature: $lowTemperature, weatherList: $weatherList, yesterDayWeatherList: $yesterDayWeatherList, location: $location, createdAt: $createdAt, seasonCode: $seasonCode}';
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
      location.hashCode ^
      createdAt.hashCode ^
      seasonCode.hashCode;

  DailyLocationWeather copyWith({
    double? highTemperature,
    double? lowTemperature,
    List<Weather>? weatherList,
    List<Weather>? yesterDayWeatherList,
    Location? location,
    DateTime? createdAt,
    int? seasonCode,
  }) {
    return DailyLocationWeather(
      highTemperature: highTemperature ?? this.highTemperature,
      lowTemperature: lowTemperature ?? this.lowTemperature,
      weatherList: weatherList ?? this.weatherList,
      yesterDayWeatherList: yesterDayWeatherList ?? this.yesterDayWeatherList,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      seasonCode: seasonCode ?? this.seasonCode,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'highTemperature': highTemperature,
      'lowTemperature': lowTemperature,
      'weatherList': weatherList.map((weather) => weather.toFirebase()).toList(),
      'yesterDayWeatherList':
          yesterDayWeatherList.map((weather) => weather.toFirebase()).toList(),
      'location': location.toFirebase(),
      'createdAt': createdAt,
      'seasonCode': seasonCode,
    };
  }

  factory DailyLocationWeather.fromFirebase(Map<String, dynamic> data) {
    return DailyLocationWeather(
      highTemperature: data['highTemperature'] as double,
      lowTemperature: data['lowTemperature'] as double,
      weatherList: (data['weatherList'] as List)
          .map((e) => Weather.fromFirebase(e))
          .toList(),
      yesterDayWeatherList: (data['yesterDayWeatherList'] as List)
          .map((e) => Weather.fromFirebase(e))
          .toList(),
      location: Location.fromFirebase(data['location']),
      createdAt: data['created_at'] as DateTime,
      seasonCode: data['season_code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'highTemperature': highTemperature,
      'lowTemperature': lowTemperature,
      'weatherList': weatherList.map((weather) => weather.toJson()).toList(),
      'yesterdayWeatherList':
          yesterDayWeatherList.map((weather) => weather.toJson()).toList(),
      'location': location.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'seasonCode': seasonCode,
    };
  }

  factory DailyLocationWeather.fromJson(Map<String, dynamic> json) {
    return DailyLocationWeather(
      highTemperature: json['highTemperature'] as double,
      lowTemperature: json['lowTemperature'] as double,
      weatherList: (json['weatherList'] as List)
          .map((e) => Weather.fromJson(e))
          .toList(),
      yesterDayWeatherList: (json['yesterdayWeatherList'] as List)
          .map((e) => Weather.fromJson(e))
          .toList(),
      location: Location.fromJson(json['location']),
      createdAt: DateTime.parse(json['createdAt']),
      seasonCode: json['seasonCode'] as int,
    );
  }
}
