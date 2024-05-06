import 'dart:developer';

import 'package:weaco/core/config/meteo_config.dart';
import 'package:weaco/core/dio/base_dio.dart';
import 'package:weaco/core/dio/base_response.dart';
import 'package:weaco/data/common/http/status_code_handler.dart';
import 'package:weaco/data/weather/data_source/remote_data_source/remote_weather_data_source.dart';
import 'package:weaco/data/weather/dto/weather_dto.dart';

class MeteoWeatherApi implements RemoteWeatherDataSource {
  final BaseDio _dio;

  MeteoWeatherApi({required BaseDio dio}) : _dio = dio;

  @override
  Future<WeatherDto> getWeather(
      {required double lat, required double lng}) async {
    final BaseResponse response = await _dio.get(
        path: '${MeteoConfig.baseUrl}/v1/forecast?hourly=temperature_2m,'
            'weathercode&latitude=$lat&longitude=$lng&lang=ko&past_days=1&'
            'forecast_days=1&daily=temperature_2m_max,temperature_2m_min');

    if (response.statusCode != 200) {
      log('Code: ${response.statusCode}, Body: ${response.body}');

      throw statusCodeHandler(code: response.statusCode);
    }
    return WeatherDto.fromJson(response.body);
  }
}
