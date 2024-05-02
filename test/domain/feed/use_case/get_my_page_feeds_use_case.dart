import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_my_page_feeds_use_case.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

import '../../../mock/data/feed/repository/mock_feed_repository_impl.dart';

void main() {
  group('GetMyPageFeedsUseCase 클래스', () {
    final mockFeedRepositoryImpl = MockFeedRepositoryImpl();
    final GetMyPageFeedsUseCase useCase =
        GetMyPageFeedsUseCase(feedRepository: mockFeedRepositoryImpl);

    group('getFeedList 메서드는', () {
      setUp(
        () => mockFeedRepositoryImpl.initMockData(),
      );

      test('이메일에 해당하는 피드 목록이 없는 경우 null을 반환한다.', () async {
        // Given
        const expectFeedList = null;
        const email = 'yoonji5809@gmail.com';

        // When
        final feedList = await useCase.execute(email: email);

        // Then
        expect(feedList, expectFeedList);
      });

      test('이메일에 해당하는 피드 목록이 있는 경우 해당 프로필을 반환한다.', () async {
        // Given
        const email = 'yoonji5809@gmail.com';
        final expectFeedList = [
          Feed(
            id: 1,
            imagePath:
                'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
            userEmail: 'yoonji5809@gmail.com',
            description: 'OOTD 설명',
            weather: Weather(
              temperature: 11,
              timeTemperature: DateTime.now(),
              code: 1,
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
            id: 2,
            imagePath:
                'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
            userEmail: 'yoonji5809@gmail.com',
            description: 'OOTD 설명',
            weather: Weather(
              temperature: 11,
              timeTemperature: DateTime.now(),
              code: 1,
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
            id: 3,
            imagePath:
                'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
            userEmail: 'yoonji5809@gmail.com',
            description: 'OOTD 설명',
            weather: Weather(
              temperature: 11,
              timeTemperature: DateTime.now(),
              code: 1,
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

        mockFeedRepositoryImpl.addFeedList(feedList: expectFeedList);

        // When
        final feedList = await useCase.execute(email: email);

        // Then
        expect(feedList, expectFeedList);
      });
    });
  });
}
