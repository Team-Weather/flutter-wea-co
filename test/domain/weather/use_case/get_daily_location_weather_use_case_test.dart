import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import 'package:weaco/domain/weather/use_case/get_daily_location_weather_use_case.dart';

import '../../../mock/data/weather/mock_daily_location_weather_repository_impl.dart';

void main() {
  group('GetDailyLocationWeatherUseCase 클래스', () {
    final mockDailyLocationWeatherRepository =
        MockDailyLocationWeatherRepositoryImpl();
    final GetDailyLocationWeatherUseCase useCase =
        GetDailyLocationWeatherUseCase(
            dailyLocationWeatherRepository: mockDailyLocationWeatherRepository);

    setUp(() {
      mockDailyLocationWeatherRepository.initMockData();
    });
    group('execute 메서드는', () {
      test('DailyLocationWeatherRepository.getDailyLocationWeather()을 한번 호출한다.',
          () async {
        // Given
        const expectedCallCount = 1;

        final expectedDailyLocationWeather = DailyLocationWeather(
          highTemperature: 15,
          lowTemperature: 12,
          weatherList: [
            Weather(
              temperature: 1,
              timeTemperature: DateTime.now(),
              code: 1,
              createdAt: DateTime.now(),
            ),
            Weather(
              temperature: 1,
              timeTemperature: DateTime.now(),
              code: 1,
              createdAt: DateTime.now(),
            )
          ],
          yesterDayWeatherList: [
            Weather(
              temperature: 1,
              timeTemperature: DateTime.now(),
              code: 1,
              createdAt: DateTime.now(),
            ),
            Weather(
              temperature: 1,
              timeTemperature: DateTime.now(),
              code: 1,
              createdAt: DateTime.now(),
            )
          ],
          location: Location(
            lat: 113.1,
            lng: 213.1,
            city: '서울시',
            createdAt: DateTime.now(),
          ),
          createdAt: DateTime.now(),
        );
        mockDailyLocationWeatherRepository.dailyLocationWeatherResult =
            expectedDailyLocationWeather;

        // When
        await useCase.execute();

        // Then
        expect(mockDailyLocationWeatherRepository.dailyLocationWeatherCallCount,
            expectedCallCount);
      });

      test(
          'DailyWeatherRepository.getDailyLocationWeather()를 호출하고 반환 받은 값을 그대로 반환한다.',
          () async {
        // Given
        const expectedCallCount = 1;

        final expectedDailyLocationWeather = DailyLocationWeather(
          highTemperature: 15,
          lowTemperature: 12,
          weatherList: [
            Weather(
              temperature: 1,
              timeTemperature: DateTime.now(),
              code: 1,
              createdAt: DateTime.now(),
            ),
            Weather(
              temperature: 1,
              timeTemperature: DateTime.now(),
              code: 1,
              createdAt: DateTime.now(),
            )
          ],
          yesterDayWeatherList: [
            Weather(
              temperature: 1,
              timeTemperature: DateTime.now(),
              code: 1,
              createdAt: DateTime.now(),
            ),
            Weather(
              temperature: 1,
              timeTemperature: DateTime.now(),
              code: 1,
              createdAt: DateTime.now(),
            )
          ],
          location: Location(
            lat: 113.1,
            lng: 213.1,
            city: '서울시',
            createdAt: DateTime.now(),
          ),
          createdAt: DateTime.now(),
        );

        mockDailyLocationWeatherRepository.dailyLocationWeatherResult =
            expectedDailyLocationWeather;
        // When
        final actualWeatherInfo = await useCase.execute();

        // Then
        expect(actualWeatherInfo, expectedDailyLocationWeather);
        expect(
          mockDailyLocationWeatherRepository.dailyLocationWeatherCallCount,
          expectedCallCount,
        );
      });
    });
  });
}
