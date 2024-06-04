import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_user_page_feeds_use_case.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

import '../../../mock/data/feed/repository/mock_feed_repository_impl.dart';

void main() {
  group('GetUserPageFeedsUseCase 클래스', () {
    final mockFeedRepository = MockFeedRepositoryImpl();
    final GetUserPageFeedsUseCase useCase =
    GetUserPageFeedsUseCase(feedRepository: mockFeedRepository);

    group('execute 메서드는', () {
      setUp(
            () => mockFeedRepository.initMockData(),
      );

      test('FeedRepository.getFeedList()를 한번 호출한다.', () async {
        // Given
        const expectCount = 1;
        const email = 'gildong@gmail.com';

        // When
        await useCase.execute(
            email: email, createdAt: DateTime.now(), limit: 20);

        // Then
        expect(mockFeedRepository.getFeedListcallCount, expectCount);
      });

      test('FeedRepository.getFeedList()를 호출하고 반환 받은 값을 그대로 반환한다.', () async {
        // Given
        const email = 'gildong@gmail.com';

        final expectFeedList = [
          Feed(
            id: '1',
            imagePath:
            'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
            thumbnailImagePath:
            'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
            userEmail: 'yoonji5809@gmail.com',
            description: 'OOTD 설명',
            weather: Weather(
              temperature: 11,
              timeTemperature: DateTime.now(),
              code: 1,
              createdAt: DateTime.parse('2024-05-01 13:27:00'),
            ),
            seasonCode: 1,
            location: Location(
              lat: 113.1,
              lng: 213.1,
              city: '서울시',
              createdAt: DateTime.now(),
            ),
            createdAt: DateTime.now(),
          ),
          Feed(
            id: '2',
            imagePath:
            'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
            thumbnailImagePath:
            'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
            userEmail: 'yoonji5809@gmail.com',
            description: 'OOTD 설명',
            weather: Weather(
                temperature: 11,
                timeTemperature: DateTime.parse('2024-05-01 13:27:00'),
                code: 1,
                createdAt: DateTime.parse('2024-05-01 13:27:00')),
            seasonCode: 1,
            location: Location(
              lat: 113.1,
              lng: 213.1,
              city: '서울시',
              createdAt: DateTime.parse('2024-05-01 13:27:00'),
            ),
            createdAt: DateTime.parse('2024-05-01 13:27:00'),
          ),
          Feed(
            id: '3',
            imagePath:
            'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
            thumbnailImagePath:
            'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
            userEmail: 'yoonji5809@gmail.com',
            description: 'OOTD 설명',
            weather: Weather(
              temperature: 11,
              timeTemperature: DateTime.now(),
              code: 1,
              createdAt: DateTime.parse('2024-05-01 13:27:00'),
            ),
            seasonCode: 1,
            location: Location(
              lat: 113.1,
              lng: 213.1,
              city: '서울시',
              createdAt: DateTime.now(),
            ),
            createdAt: DateTime.now(),
          )
        ];

        mockFeedRepository.addFeedList(feedList: expectFeedList);

        // When
        final feedList = await useCase.execute(
            email: email, createdAt: DateTime.now(), limit: 20);

        // Then
        expect(feedList, expectFeedList);
      });
    });
  });
}
