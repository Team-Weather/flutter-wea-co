import 'dart:convert';

import 'package:weaco/core/hive/hive_wrapper.dart';
import 'package:weaco/domain/weather/data_source/local_daily_location_weather_data_source.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';

class LocalDailyLocationWeatherDataSourceImpl
    implements LocalDailyLocationWeatherDataSource {
  static const String dailyLocationWeatherKey = 'daily_location_weather_key';
  final HiveWrapper _hiveWrapper;

  const LocalDailyLocationWeatherDataSourceImpl({
    required HiveWrapper hiveWrapper,
  }) : _hiveWrapper = hiveWrapper;

  @override
  Future<void> saveLocalDailyLocationWeather({
    required DailyLocationWeather dailyLocationWeather,
  }) async {
    await _hiveWrapper.writeData(dailyLocationWeatherKey, dailyLocationWeather);
  }

  @override
  Future<DailyLocationWeather?> getLocalDailyLocationWeather() async {
    final data = await _hiveWrapper.readData(dailyLocationWeatherKey);
    return DailyLocationWeather.fromJson(jsonDecode(data));
  }
}
