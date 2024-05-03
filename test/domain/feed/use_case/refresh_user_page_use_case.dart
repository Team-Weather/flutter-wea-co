import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/refresh_user_page_use_case.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

import '../../../mock/data/feed/repository/mock_feed_repository_impl.dart';

void main() {
  group('RefreshUserPageUseCase 클래스', () {
    final MockFeedRepositoryImpl mockFeedRepositoryImpl =
        MockFeedRepositoryImpl();
    final RefreshUserPageUseCase refreshUserPageUseCase =
        RefreshUserPageUseCase(feedRepository: mockFeedRepositoryImpl);

    setUp(() {
      mockFeedRepositoryImpl.initMockData();
    });

    group('execute() 메소드는', () {
      test('getFeedList() 메소드를 1회 호출한다.', () async {
        const int expectCallCount = 1;

        final Map<String, dynamic> expectedParameterMap = {
          'email': 'qoophon@gmail.com',
          'limit': 20,
          'createdAt': null,
        };

        await refreshUserPageUseCase.execute(
          email: expectedParameterMap['email'],
          limit: expectedParameterMap['limit'],
          createdAt: expectedParameterMap['createdAt'],
        );

        expect(mockFeedRepositoryImpl.getFeedListcallCount, expectCallCount);
      });
      test('전달 받은 인자를 getFeedList() 메소드에 그대로 전달한다.', () async {
        final Map<String, dynamic> expectedParameterMap = {
          'email': 'qoophon@gmail.com',
          'limit': 20,
          'createdAt': null,
        };

        await refreshUserPageUseCase.execute(
          email: expectedParameterMap['email'],
          limit: expectedParameterMap['limit'],
          createdAt: expectedParameterMap['createdAt'],
        );

        expect(mockFeedRepositoryImpl.methodParameterMap, expectedParameterMap);
      });
      test('getFeedList() 메소드를 각각 호출하고 반환받은 값을 List 형태로 반환한다.', () async {
        final Map<String, dynamic> expectedParameterMap = {
          'email': 'qoophon@gmail.com',
          'limit': 20,
          'createdAt': null,
        };

        final expectFeedList = [
          Feed(
            id: '1',
            imagePath:
                'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
            userEmail: 'qoophon@gmail.com',
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
            userEmail: 'qoophon@gmail.com',
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
            userEmail: 'qoophon@gmail.com',
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

        mockFeedRepositoryImpl.addFeedList(feedList: expectFeedList);

        final List<Feed>? actualFeedList = await refreshUserPageUseCase.execute(
          email: expectedParameterMap['email'],
          limit: expectedParameterMap['limit'],
          createdAt: expectedParameterMap['createdAt'],
        );

        expect(actualFeedList, expectFeedList);
      });
    });
  });
}
