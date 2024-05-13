import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/feed/use_case/get_ootd_feeds_use_case.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import '../../../mock/data/feed/repository/mock_feed_repository_impl.dart';

void main() {
  group('GetOotdFeedsUseCase 클래스', () {
    final mockFeedRepository = MockFeedRepositoryImpl();
    final GetOotdFeedsUseCase useCase =
        GetOotdFeedsUseCase(feedRepository: mockFeedRepository);

    group('execute 메서드는', () {
      setUp(
        () => mockFeedRepository.initMockData(),
      );

      test('FeedRepository.getOotdList()를 한번 호출한다.', () async {
        // Given
        const expectCount = 1;
        Weather mockWeather = Weather(
          temperature: 25,
          timeTemperature: DateTime.parse('2024-05-06'),
          code: 1,
          createdAt: DateTime.parse('2024-05-06'),
        );

        Location mockLocation = Location(
          lat: 31.23,
          lng: 29.48,
          city: '서울시, 노원구',
          createdAt: DateTime.parse('2024-05-06'),
        );

        final mockDailyLocationWeather = DailyLocationWeather(
          seasonCode: 0,
          highTemperature: 30,
          lowTemperature: 20,
          weatherList: [
            mockWeather,
            mockWeather,
            mockWeather,
          ],
          yesterDayWeatherList: [
            mockWeather,
            mockWeather,
            mockWeather,
          ],
          location: mockLocation,
          createdAt: DateTime.now(),
        );

        // When
        await useCase.execute(
          createdAt: DateTime.now(),
          dailyLocationWeather: mockDailyLocationWeather,
        );

        // Then
        expect(mockFeedRepository.getOotdFeedsListCallCount, expectCount);
      });
    });
  });
}
