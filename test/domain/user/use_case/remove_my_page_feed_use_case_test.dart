import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/remove_my_page_feed_use_case.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import '../../../mock/data/feed/repository/mock_feed_repository_impl.dart';

void main() {
  group('RemoveMyPageFeedUseCase 클래스', () {
    final mockFeedRepository = MockFeedRepositoryImpl();
    final RemoveMyPageFeedUseCase useCase =
    RemoveMyPageFeedUseCase(feedRepository: mockFeedRepository);

    group('RemoveMyPageFeedUseCase는', () {
      test('RemoveMyPageFeed test', () async {
        // Given
        const testId = 'testId';
        final testLocation = Location(
            lat: 37.123456,
            lng: 127.123456,
            city: '서울시, 노원구',
            createdAt: DateTime.now());
        final testWeather = Weather(
          temperature: 20.0,
          timeTemperature: DateTime.now(),
          code: 1,
          createdAt: DateTime.now(),
        );

        final testFeed = Feed(
            id: testId,
            userEmail: 'test@email.com',
            imagePath: 'imagePath',
            description: 'description',
            weather: testWeather,
            seasonCode: 1,
            location: testLocation, createdAt: DateTime.now());

        // When
        mockFeedRepository.feed = testFeed;
        final result = await useCase.execute(id: testId);

        // Then
        expect(result, true);
      });
    });
  });
}
