import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/data/weather/data_source/local_data_source/local_daily_location_weather_data_source.dart';
import 'package:weaco/data/weather/data_source/local_data_source/local_daily_location_weather_data_source_impl.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';

import '../../../../mock/core/hive/mock_hive_wrapper.dart';

void main() async {
  group('LocalDailyLocationWeatherDataSourceImpl 클래스', () {
    final hiveWrapper = MockHiveWrapper();
    final LocalDailyLocationWeatherDataSource
        localDailyLocationWeatherDataSource =
        LocalDailyLocationWeatherDataSourceImpl(hiveWrapper: hiveWrapper);

    setUp(() async {
      await hiveWrapper.initMockData();
    });

    group('saveLocalDailyLocationWeather 메서드는', () {
      test('로컬에 DailyLocationWeather 데이터를 저장한다.', () async {
        // Given
        const String testKey = 'daily_location_weather_key';

        final dateNow = DateTime.now();

        final actualDailyLocationWeather = {
          "highTemperature": 21.0,
          "lowTemperature": 12.0,
          "weatherList": [
            {
              "temperature": 1.0,
              "timeTemperature": dateNow.toIso8601String(),
              "code": 1,
              "createdAt": dateNow.toIso8601String(),
            },
            {
              "temperature": 1.0,
              "timeTemperature": dateNow.toIso8601String(),
              "code": 1,
              "createdAt": dateNow.toIso8601String(),
            }
          ],
          "yesterdayWeatherList": [
            {
              "temperature": 1.0,
              "timeTemperature": dateNow.toIso8601String(),
              "code": 1,
              "createdAt": dateNow.toIso8601String(),
            },
            {
              "temperature": 1.0,
              "timeTemperature": dateNow.toIso8601String(),
              "code": 1,
              "createdAt": dateNow.toIso8601String(),
            }
          ],
          "location": {
            "lat": 113.1,
            "lng": 213.1,
            "city": '서울시',
            "createdAt": dateNow.toIso8601String(),
          },
          "createdAt": dateNow.toIso8601String(),
          "seasonCode": 0,
        };

        final dailyLocationWeather = DailyLocationWeather(
          highTemperature: 21,
          lowTemperature: 12,
          weatherList: [
            Weather(
              temperature: 1,
              timeTemperature: dateNow,
              code: 1,
              createdAt: dateNow,
            ),
            Weather(
              temperature: 1,
              timeTemperature: dateNow,
              code: 1,
              createdAt: dateNow,
            )
          ],
          yesterDayWeatherList: [
            Weather(
              temperature: 1,
              timeTemperature: dateNow,
              code: 1,
              createdAt: dateNow,
            ),
            Weather(
              temperature: 1,
              timeTemperature: dateNow,
              code: 1,
              createdAt: dateNow,
            )
          ],
          location: Location(
            lat: 113.1,
            lng: 213.1,
            city: '서울시',
            createdAt: dateNow,
          ),
          createdAt: dateNow,
          seasonCode: 0,
        );

        await hiveWrapper.writeData(
          testKey,
          jsonEncode(actualDailyLocationWeather),
        );

        // When
        await localDailyLocationWeatherDataSource.saveLocalDailyLocationWeather(
          dailyLocationWeather: dailyLocationWeather,
        );

        // Then
        expect(testKey, hiveWrapper.mockKey);
        expect(jsonEncode(actualDailyLocationWeather), hiveWrapper.mockValue);
      });
    });

    group('getLocalDailyLocationWeather 메서드는', () {
      test('로컬에 저장된 DailyLocationWeather 데이터를 반환한다.', () async {
        // Given
        const String testKey = 'daily_location_weather_key';
        final data = await hiveWrapper.readData(testKey);
        DailyLocationWeather.fromHive(jsonDecode(data));

        // When
        final expectData = await localDailyLocationWeatherDataSource.getLocalDailyLocationWeather();

        // Then
        expect(testKey, hiveWrapper.mockKey);
        expect(DailyLocationWeather.fromHive(jsonDecode(data)), expectData);
      });
    });
  });
}
