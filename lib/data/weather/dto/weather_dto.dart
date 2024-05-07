import 'package:weaco/data/weather/dto/daily_dto.dart';
import 'package:weaco/data/weather/dto/hourly_dto.dart';

class WeatherDto {
  num? _latitude;
  num? _longitude;
  HourlyDto? _hourly;
  DailyDto? _daily;

  WeatherDto({
    num? latitude,
    num? longitude,
    HourlyDto? hourly,
    DailyDto? daily,
  }) {
    _latitude = latitude;
    _longitude = longitude;
    _hourly = hourly;
    _daily = daily;
  }

  WeatherDto.fromJson({required dynamic json}) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _hourly = json['hourly'] != null
        ? HourlyDto.fromJson(json: json['hourly'])
        : null;
    _daily =
        json['daily'] != null ? DailyDto.fromJson(json: json['daily']) : null;
  }

  WeatherDto copyWith({
    num? latitude,
    num? longitude,
    HourlyDto? hourly,
    DailyDto? daily,
  }) =>
      WeatherDto(
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        hourly: hourly ?? _hourly,
        daily: daily ?? _daily,
      );

  num? get latitude => _latitude;

  num? get longitude => _longitude;

  HourlyDto? get hourly => _hourly;

  DailyDto? get daily => _daily;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    if (_hourly != null) {
      map['hourly'] = _hourly?.toJson();
    }
    if (_daily != null) {
      map['daily'] = _daily?.toJson();
    }
    return map;
  }

  @override
  String toString() {
    return 'WeatherDto{_latitude: $_latitude, _longitude: $_longitude, _hourly: $_hourly, _daily: $_daily}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherDto &&
          runtimeType == other.runtimeType &&
          _latitude == other._latitude &&
          _longitude == other._longitude &&
          _hourly == other._hourly &&
          _daily == other._daily;

  @override
  int get hashCode =>
      _latitude.hashCode ^
      _longitude.hashCode ^
      _hourly.hashCode ^
      _daily.hashCode;
}
