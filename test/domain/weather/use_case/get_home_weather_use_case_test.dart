import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import 'package:weaco/domain/weather/use_case/get_home_weather_use_case.dart';

import '../../../mock/data/weather/mock_weather_repository_impl.dart';

void main() {
  group('GetHomeWeatherUseCase 클래스', () {
    final mockDailyWeatherRepository = MockDailyWeatherRepositoryImpl();
    final GetHomeWeatherUseCase useCase =
        GetHomeWeatherUseCase(weatherRepository: mockDailyWeatherRepository);

    setUp(() {
      mockDailyWeatherRepository.initMockData();
    });
    group('execute 메서드는', () {
      test('DailyWeatherRepository.getDailyLocationWeather()을 한번 호출한다.',
          () async {
        // Given
        const expectedCallCount = 1;
        final date = DateTime.now();
        final location = Location(
          lat: 113.1,
          lng: 213.1,
          city: '서울시',
          createdAt: DateTime.now(),
        );

        // When
        await useCase.execute(
          date: date,
          location: location,
        );

        // Then
        expect(mockDailyWeatherRepository.dailyLocationWeatherCallCount,
            expectedCallCount);
      });

      test(
          'DailyWeatherRepository.getDailyLocationWeather()를 호출하고 반환 받은 값을 그대로 반환한다.',
          () async {
        // Given
        const expectedCallCount = 1;
        final date = DateTime.now();
        final location = Location(
          lat: 113.1,
          lng: 213.1,
          city: '서울시',
          createdAt: DateTime.now(),
        );

        final dailyLocationWeather = DailyLocationWeather(
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
          location: Location(
            lat: 113.1,
            lng: 213.1,
            city: '서울시',
            createdAt: DateTime.now(),
          ),
          createdAt: DateTime.now(),
        );

        mockDailyWeatherRepository.dailyLocationWeatherResult =
            dailyLocationWeather;
        // When
        final weatherInfo = await useCase.execute(
          date: date,
          location: location,
        );

        // Then
        expect(weatherInfo, dailyLocationWeather);
        expect(
          mockDailyWeatherRepository.dailyLocationWeatherCallCount,
          expectedCallCount,
        );
      });
    });
  });
}
