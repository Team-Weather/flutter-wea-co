import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/save_edit_feed_use_case.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import '../../../mock/data/feed/repository/mock_feed_repository_impl.dart';

void main() {
  group('SaveEditFeedUseCase 클래스', () {
    final feedRepository = MockFeedRepositoryImpl();
    final saveEditFeedUseCase =
        SaveEditFeedUseCase(feedRepository: feedRepository);

    setUp(() => feedRepository.initMockData());

    group('execute 메소드는', () {
      test('파라미터로 받은 새 feed를 FeedRepository.saveFeed에 넘긴다.', () async {
        // Given
        const bool expectedResponse = true;
        const int expectedCallCount = 1;

        final mockFeedNew = Feed(
          id: '',
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

        // When
        final response = await saveEditFeedUseCase.execute(feed: mockFeedNew);

        // Then
        expect(feedRepository.saveFeedCallCount, expectedCallCount);
        expect(response, expectedResponse);
      });

      test('파라미터로 받은 수정된 feed를 FeedRepository.saveFeed에 넘긴다.', () async {
        // Given
        const int expectedCallCount = 1;
        const bool expectedResponse = true;
        final editedFeed = Feed(
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
        feedRepository.getFeedResult = editedFeed;

        // When
        final response = await saveEditFeedUseCase.execute(feed: editedFeed);

        // Then
        expect(feedRepository.saveFeedCallCount, expectedCallCount);
        expect(response, expectedResponse);
      });
    });
  });
}
