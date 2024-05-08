import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_recommended_feeds_use_case.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';

import '../../../mock/data/feed/repository/mock_feed_repository_impl.dart';

void main() {
  group('GetUserPageUserProfileUseCase 클래스', () {
    final mockFeedRepository = MockFeedRepositoryImpl();
    final GetRecommendedFeedsUseCase useCase =
        GetRecommendedFeedsUseCase(feedRepository: mockFeedRepository);

    setUp(() {
      mockFeedRepository.initMockData();

      final expectedDailyLocationWeather = DailyLocationWeather(
        seasonCode: 0,
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

      mockFeedRepository.dailyLocationWeather = expectedDailyLocationWeather;
    });

    group('execute 메서드는', () {
      test('FeedRepository.getRecommendedFeeds()을 한번 호출한다.', () async {
        // Given
        const expectCount = 1;

        // When
        await useCase.execute(
            dailyLocationWeather: mockFeedRepository.dailyLocationWeather!);

        // Then
        expect(mockFeedRepository.getRecommendedFeedsCallCount, expectCount);
      });

      test('FeedRepository.getRecommendedFeeds()를 호출하고 반환 받은 값을 그대로 반환한다.',
          () async {
        // Given
        final feed1 = Feed(
            id: '0',
            imagePath: '',
            userEmail: 'hoogom87@gmail.com',
            description: '오늘의 OOTD',
            weather: Weather(
                code: 0,
                temperature: 23.4,
                timeTemperature: DateTime.now(),
                createdAt: DateTime.now()),
            seasonCode: 0,
            location: Location(
                createdAt: DateTime.now(),
                lat: 38.325,
                lng: 128.4356,
                city: '서울'),
            createdAt: DateTime.now(),
            deletedAt: DateTime.now());
        final feed2 = feed1.copyWith(
            weather: Weather(
                temperature: 26.4,
                timeTemperature: DateTime.now(),
                code: 1,
                createdAt: DateTime.now()));
        final feed3 = feed1.copyWith(
            seasonCode: 1,
            weather: Weather(
                temperature: 18.4,
                timeTemperature: DateTime.now(),
                code: 2,
                createdAt: DateTime.now()));
        final feed4 = feed1.copyWith(
            seasonCode: 2,
            weather: Weather(
                temperature: 9.4,
                timeTemperature: DateTime.now(),
                code: 3,
                createdAt: DateTime.now()));
        mockFeedRepository.addFeed(feed: feed1);
        mockFeedRepository.addFeed(feed: feed2);
        mockFeedRepository.addFeed(feed: feed3);
        mockFeedRepository.addFeed(feed: feed4);

        // When
        final result = await useCase.execute(
            dailyLocationWeather: mockFeedRepository.dailyLocationWeather!);

        // Then
        expect(result, [feed1, feed2, feed3, feed4]);
      });
    });
  });
}
