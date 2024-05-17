import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/data/feed/repository/feed_repository_impl.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';

import '../../../mock/data/feed/data_source/mock_remote_feed_data_source.dart';

void main() {
  final mockFeedDataSource = MockRemoteFeedDataSource();
  final feedRepository =
      FeedRepositoryImpl(remoteFeedDataSource: mockFeedDataSource);

  group('FeedRepositoryImpl 클래스', () {
    final mockFeed = Feed(
      id: 'id',
      imagePath: 'imagePath',
      userEmail: 'userEmail',
      description: 'description',
      weather: Weather(
        temperature: 1,
        timeTemperature: DateTime.parse('2024-05-01 13:27:00'),
        code: 1,
        createdAt: DateTime.parse('2024-05-01 13:27:00'),
      ),
      seasonCode: 1,
      location: Location(
        lat: 1,
        lng: 1,
        city: 'city',
        createdAt: DateTime.parse('2024-05-01 13:27:00'),
      ),
      createdAt: DateTime.parse('2024-05-01 13:27:00'),
      deletedAt: null,
    );

    setUp(() {
      mockFeedDataSource.feedList = [mockFeed, mockFeed, mockFeed];
    });

    tearDown(() => mockFeedDataSource.cleanUpMockData());

    test('saveFeed는', () async {
      // given
      final mockFeed = Feed(
        id: 'id',
        imagePath: 'imagePath',
        userEmail: 'userEmail',
        description: 'description',
        weather: Weather(
          temperature: 1,
          timeTemperature: DateTime.now(),
          code: 1,
          createdAt: DateTime.now(),
        ),
        seasonCode: 1,
        location: Location(
          lat: 1,
          lng: 1,
          city: 'city',
          createdAt: DateTime.now(),
        ),
        createdAt: DateTime.now(),
        deletedAt: null,
      );

      mockFeedDataSource.saveFeedReturnValue = true;
      // when
      final actual = await feedRepository.saveFeed(editedFeed: mockFeed);

      // then
      expect(actual, true);
      expect(mockFeedDataSource.feedList.last, mockFeed);
    });
    test('deleteFeed는', () async {
      // Given
      const expectedId = 'id';
      const expectedBool = true;

      mockFeedDataSource.deleteFeedReturnValue = expectedBool;

      // When
      final actual = await feedRepository.deleteFeed(id: expectedId);

      // Then
      expect(mockFeedDataSource.deleteFeedParamId, expectedId);
      expect(actual, expectedBool);
    });
    test('getUserFeedList는', () async {
      // Given
      final expectedList = mockFeedDataSource.feedList;

      // When
      final actual = await feedRepository.getUserFeedList(
        email: 'userEmail',
        createdAt: DateTime.now(),
        limit: 10,
      );

      // Then
      expect(actual, expectedList);
    });
    test('getOotdFeedList는', () async {
      // Given
      final expectedList = mockFeedDataSource.feedList;

      // When
      final actual = await feedRepository.getOotdFeedList(
        createdAt: DateTime.now(),
        dailyLocationWeather: DailyLocationWeather(
          highTemperature: 25,
          lowTemperature: 14,
          weatherList: [],
          yesterDayWeatherList: [],
          tomorrowWeatherList: [],
          location: Location(
            lat: 13,
            lng: 141,
            city: 'city',
            createdAt: DateTime.parse('2024-05-01 13:27:00'),
          ),
          createdAt: DateTime.parse('2024-05-01 13:27:00'),
          seasonCode: 0,
        ),
      );

      // Then
      expect(actual, expectedList);
    });
    test('getRecommendedFeedList는', () async {
      // Given
      final expectedList = mockFeedDataSource.feedList;

      // When
      final actual = await feedRepository.getRecommendedFeedList(
        dailyLocationWeather: DailyLocationWeather(
          highTemperature: 25,
          lowTemperature: 14,
          weatherList: [],
          yesterDayWeatherList: [],
          tomorrowWeatherList: [],
          location: Location(
            lat: 13,
            lng: 141,
            city: 'city',
            createdAt: DateTime.now(),
          ),
          createdAt: DateTime.now(),
          seasonCode: 0,
        ),
      );

      // Then
      expect(actual, expectedList);
    });
    test('getSearchFeedList', () async {
      // Given
      final expectedList = mockFeedDataSource.feedList;
      final createdAt = DateTime.now();
      const limit = 0;
      const seasonCode = 1;
      const weatherCode = 0;
      const minTemperature = 0;
      const maxTemperature = 10;

      // When
      final actual = await feedRepository.getSearchFeedList(
        createdAt: createdAt,
        limit: limit,
        seasonCode: seasonCode,
        weatherCode: weatherCode,
        minTemperature: minTemperature,
        maxTemperature: maxTemperature,
      );

      // Then
      expect(actual, expectedList);
      expect(mockFeedDataSource.paramMap['createdAt'], createdAt);
      expect(mockFeedDataSource.paramMap['limit'], limit);
      expect(mockFeedDataSource.paramMap['seasonCode'], seasonCode);
      expect(mockFeedDataSource.paramMap['weatherCode'], weatherCode);
      expect(mockFeedDataSource.paramMap['minTemperature'], minTemperature);
      expect(mockFeedDataSource.paramMap['maxTemperature'], maxTemperature);
    });
    test('getFeed', () async {
      // Given
      final mockFeed = Feed(
        id: 'id',
        imagePath: 'imagePath',
        userEmail: 'userEmail',
        description: 'description',
        weather: Weather(
          temperature: 1,
          timeTemperature: DateTime.parse('2024-05-01 13:27:00'),
          code: 1,
          createdAt: DateTime.parse('2024-05-01 13:27:00'),
        ),
        seasonCode: 1,
        location: Location(
          lat: 1,
          lng: 1,
          city: 'city',
          createdAt: DateTime.parse('2024-05-01 13:27:00'),
        ),
        createdAt: DateTime.parse('2024-05-01 13:27:00'),
        deletedAt: null,
      );

      const expectedId = 'id';
      // When
      final actual = await feedRepository.getFeed(id: expectedId);

      // Then
      expect(actual, mockFeed);
      expect(expectedId, mockFeedDataSource.getFeedId);
    });
  });
}
