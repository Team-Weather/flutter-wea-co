import 'dart:developer';

import 'package:weaco/data/weather/data_source/remote_data_source/remote_weather_data_source.dart';
import 'package:weaco/data/weather/dto/weather_dto.dart';
import 'package:weaco/data/weather/mapper/daily_location_weather_mapper.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';
import 'package:weaco/data/weather/data_source/local_data_source/local_daily_location_weather_data_source.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/repository/daily_location_weather_repository.dart';

class DailyLocationWeatherRepositoryImpl
    implements DailyLocationWeatherRepository {
  final LocalDailyLocationWeatherDataSource
      _localDailyLocationWeatherDataSource;
  final RemoteWeatherDataSource _remoteWeatherDataSource;
  final LocationRepository _locationRepository;

  DailyLocationWeatherRepositoryImpl({
    required LocalDailyLocationWeatherDataSource
        localDailyLocationWeatherDataSource,
    required RemoteWeatherDataSource remoteWeatherDataSource,
    required LocationRepository locationRepository,
  })  : _localDailyLocationWeatherDataSource =
            localDailyLocationWeatherDataSource,
        _remoteWeatherDataSource = remoteWeatherDataSource,
        _locationRepository = locationRepository;

  /// 로컬 DailyLocationWeather가 없거나 만료된 데이터인 경우 새로운 데이터를 가져와서 반환한다.
  @override
  Future<DailyLocationWeather> getDailyLocationWeather() async {
    DailyLocationWeather result;
    final DailyLocationWeather? localData =
        await _localDailyLocationWeatherDataSource
            .getLocalDailyLocationWeather();

    if (_isOldDataOrExpired(localData)) {
      result = await _fetchAndCacheDailyLocationWeather();
    } else {
      result = localData!;
    }

    return result;
  }

  /// 로컬 데이터가 없거나 만료된 데이터인지 확인한다.
  bool _isOldDataOrExpired(DailyLocationWeather? localData) {
    bool result = false;
    if (localData == null ||
        localData.createdAt
            .isBefore(DateTime.now().subtract(const Duration(hours: 3)))) {
      result = true;
    }

    return result;
  }

  /// 날씨와 위치를 가져와서 DailyLocationWeather로 변환한다.
  /// 변환한 데이터를 로컬에 캐싱하고 반환한다.
  Future<DailyLocationWeather> _fetchAndCacheDailyLocationWeather() async {
    Location? location = await _locationRepository.getLocation();
    WeatherDto weatherDto = await _remoteWeatherDataSource.getWeather(
        lat: location!.lat, lng: location.lng);

    DailyLocationWeather dailyLocationWeather =
        weatherDto.toDailyLocationWeather(location: location);

    _localDailyLocationWeatherDataSource
        .saveLocalDailyLocationWeather(
            dailyLocationWeather: dailyLocationWeather)
        .catchError(
            (e) => log('name: _fetchAndCacheDailyLocationWeather, e: $e'));

    return dailyLocationWeather;
  }
}
