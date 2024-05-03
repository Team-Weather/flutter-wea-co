import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_search_feeds_use_case.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

import '../../../mock/data/feed/repository/mock_feed_repository_impl.dart';

void main() {
  group('GetSearchFeedsUseCase 클래스', () {
    final mockFeedRepository = MockFeedRepositoryImpl();
    final GetSearchFeedsUseCase getSearchFeedsUseCase =
        GetSearchFeedsUseCase(feedRepository: mockFeedRepository);

    setUp(() => mockFeedRepository.initMockData());

    group('execute 메서드는', () {
      test('FeedRepository.getSearchFeeds()을 한번 호출한다.', () async {
        // Given
        const expectCount = 1;

        // When
        await getSearchFeedsUseCase.execute();

        // Then
        expect(mockFeedRepository.getSearchFeedsCallCount, expectCount);
      });

      test('인자로 받은 필터링 조건을 FeedRepository.getSearchFeeds()에 그대로 전달한다.',
          () async {
        // Given
        const seasonCode = 0;
        const weatherCode = 0;
        const minTemperature = 20;
        const maxTemperature = 25;

        // When
        await getSearchFeedsUseCase.execute(
            seasonCode: seasonCode,
            weatherCode: weatherCode,
            minTemperature: minTemperature,
            maxTemperature: maxTemperature);

        // Then
        expect(mockFeedRepository.methodParameterMap['seasonCode'], seasonCode);
        expect(
            mockFeedRepository.methodParameterMap['weatherCode'], weatherCode);
        expect(mockFeedRepository.methodParameterMap['minTemperature'],
            minTemperature);
        expect(mockFeedRepository.methodParameterMap['maxTemperature'],
            maxTemperature);
      });

      test('FeedRepository.getSearchFeeds()를 호출하고 반환 받은 값을 그대로 반환한다.',
          () async {
        // Given
        final feed1 = Feed(
            id: '0',
            imagePath: '',
            userEmail: 'qoophon@gmail.com',
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
        final result1 = await getSearchFeedsUseCase.execute();
        final result2 = await getSearchFeedsUseCase.execute(seasonCode: 0);
        final result3 = await getSearchFeedsUseCase.execute(seasonCode: 1);
        final result4 = await getSearchFeedsUseCase.execute(
            minTemperature: 0, maxTemperature: 10);
        final result5 = await getSearchFeedsUseCase.execute(
            minTemperature: 10, maxTemperature: 20);
        final result6 = await getSearchFeedsUseCase.execute(
            minTemperature: 0, maxTemperature: 20);
        final result7 = await getSearchFeedsUseCase.execute(
            seasonCode: 2, minTemperature: 0, maxTemperature: 20);
        final result8 = await getSearchFeedsUseCase.execute(weatherCode: 3);
        final result9 = await getSearchFeedsUseCase.execute(weatherCode: 4);

        // Then
        expect(result1, [feed1, feed2, feed3, feed4]);
        expect(result2, [feed1, feed2]);
        expect(result3, [feed3]);
        expect(result4, [feed4]);
        expect(result5, [feed3]);
        expect(result6, [feed3, feed4]);
        expect(result7, [feed4]);
        expect(result8, [feed4]);
        expect(result9, []);
      });
    });
  });
}
