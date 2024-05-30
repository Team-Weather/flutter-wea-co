import 'dart:convert';

import 'package:weaco/core/hive/hive_wrapper.dart';
import 'package:weaco/data/weather/data_source/local_data_source/local_daily_location_weather_data_source.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';

class LocalDailyLocationWeatherDataSourceImpl
    implements LocalDailyLocationWeatherDataSource {
  static const String dailyLocationWeatherKey = 'daily_location_weather_key';
  final HiveWrapper _hiveWrapper;

  const LocalDailyLocationWeatherDataSourceImpl({
    required HiveWrapper hiveWrapper,
  }) : _hiveWrapper = hiveWrapper;

  /// 로컬에 DailyLocationWeather 데이터를 저장한다.
  @override
  Future<void> saveLocalDailyLocationWeather({
    required DailyLocationWeather dailyLocationWeather,
  }) async {
    await _hiveWrapper.writeData(
      dailyLocationWeatherKey,
      jsonEncode(dailyLocationWeather.toJson()),
    );
  }

  /// 로컬의 DailyLocationWeather 데이터를 가져와서 반환한다.
  @override
  Future<DailyLocationWeather?> getLocalDailyLocationWeather() async {
    final data = await _hiveWrapper.readData(dailyLocationWeatherKey);
    if (data == null) return null;
    return DailyLocationWeather.fromJson(jsonDecode(data));
  }
}
