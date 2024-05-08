import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/data/weather/dto/daily_dto.dart';
import 'package:weaco/data/weather/dto/hourly_dto.dart';
import 'package:weaco/data/weather/dto/weather_dto.dart';
import 'package:weaco/data/weather/mapper/daily_location_weather_mapper.dart';
import 'package:weaco/data/weather/repository/daily_location_weather_repository_impl.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/repository/daily_location_weather_repository.dart';

import '../../../mock/data/location/repository/mock_location_repository_impl.dart';
import '../../../mock/data/weather/data_source/local_data_source/mock_local_daily_location_weather_data_source_impl.dart';
import '../../../mock/data/weather/data_source/remote_data_source/mock_remote_weather_data_source_impl.dart';

void main() {
  group('DailyLocationRepositoryImpl 클래스', () {
    final MockLocalDailyLocationWeatherDataSourceImpl
        localDailyLocationWeatherDataSource =
        MockLocalDailyLocationWeatherDataSourceImpl();
    final MockRemoteWeatherDataSourceImpl remoteWeatherDataSource =
        MockRemoteWeatherDataSourceImpl();
    final MockLocationRepositoryImpl locationRepository =
        MockLocationRepositoryImpl();
    final DailyLocationWeatherRepository dailyLocationWeatherRepository =
        DailyLocationWeatherRepositoryImpl(
      localDailyLocationWeatherDataSource: localDailyLocationWeatherDataSource,
      remoteWeatherDataSource: remoteWeatherDataSource,
      locationRepository: locationRepository,
    );
    const double latitude = 37.5665;
    const double longitude = 126.978;
    DateTime now = DateTime.now();
    WeatherDto weatherDto = WeatherDto(
      latitude: latitude,
      longitude: longitude,
      daily: DailyDto(
        time:
            List.generate(2, (index) => '${now.year}-${now.month}-${now.day}'),
        temperature2mMax: [20],
        temperature2mMin: [10],
      ),
      hourly: HourlyDto(
          time: List.generate(
              48,
              (index) =>
                  '${now.year}-${now.month.toString().padLeft(2, '0')}-${(index ~/ 24 <= 1 ? now.day.toString().padLeft(2, '0') : (now.day - 1).toString().padLeft(2, '0'))}T${(index % 24).toString().padLeft(2, '0')}:00:00'),
          temperature2m: List.generate(48, (index) => 15.0),
          weathercode: List.generate(48, (index) => 1)),
    );

    Location location =
        Location(lat: latitude, lng: longitude, city: '서울', createdAt: now);

    DailyLocationWeather dailyLocationWeather =
        weatherDto.toDailyLocationWeather(location: location);

    setUp(() {
      localDailyLocationWeatherDataSource.initMockData();
      remoteWeatherDataSource.initMockData();
      locationRepository.initMockData();
    });

    group('getDailyLocationWeather 메서드는', () {
      test('로컬 DailyLocationWeather가 없을 경우, 새로운 데이터를 가져와 반환한다.', () async {
        // Given
        localDailyLocationWeatherDataSource.getLocalDailyLocationWeatherResult =
            null;
        remoteWeatherDataSource.getWeatherResult = weatherDto;
        locationRepository.getLocationResult = location;

        // When
        await dailyLocationWeatherRepository.getDailyLocationWeather();

        // Then
        expect(
            localDailyLocationWeatherDataSource
                .getLocalDailyLocationWeatherResult,
            isNull);
        expect(
            localDailyLocationWeatherDataSource
                .getLocalDailyLocationWeatherCallCount,
            1);
        expect(remoteWeatherDataSource.getWeatherCallCount, 1);
        expect(locationRepository.getLocationCallCount, 1);
        expect(
            localDailyLocationWeatherDataSource
                .saveLocalDailyLocationWeatherCallCount,
            1);
      });

      test('로컬 DailyLocationWeather가 생성된지 3시간이 지났을 경우, 새로운 데이터를 가져와 반환한다.',
          () async {
        // Given
        localDailyLocationWeatherDataSource.getLocalDailyLocationWeatherResult =
            dailyLocationWeather.copyWith(
                createdAt: now.subtract(const Duration(hours: 4)));
        remoteWeatherDataSource.getWeatherResult = weatherDto;
        locationRepository.getLocationResult = location;

        // When
        final DailyLocationWeather actual =
            await dailyLocationWeatherRepository.getDailyLocationWeather();

        // Then
        expect(actual.createdAt.isAfter(now.subtract(const Duration(hours: 3))),
            isTrue);
        expect(
            localDailyLocationWeatherDataSource
                .getLocalDailyLocationWeatherCallCount,
            1);
        expect(remoteWeatherDataSource.getWeatherCallCount, 1);
        expect(locationRepository.getLocationCallCount, 1);
        expect(
            localDailyLocationWeatherDataSource
                .saveLocalDailyLocationWeatherCallCount,
            1);
      });

      test('로컬 DailyLocationWeather가 최신 데이터인 경우, 로컬 데이터를 반환한다.', () async {
        // Given
        localDailyLocationWeatherDataSource.getLocalDailyLocationWeatherResult =
            dailyLocationWeather;

        // When
        final DailyLocationWeather actual =
            await dailyLocationWeatherRepository.getDailyLocationWeather();

        // Then
        expect(actual, dailyLocationWeather);
        expect(
            localDailyLocationWeatherDataSource
                .getLocalDailyLocationWeatherCallCount,
            1);
        expect(remoteWeatherDataSource.getWeatherCallCount, 0);
        expect(locationRepository.getLocationCallCount, 0);
        expect(
            localDailyLocationWeatherDataSource
                .saveLocalDailyLocationWeatherCallCount,
            0);
      });
    });
  });
}
