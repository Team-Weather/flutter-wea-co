import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/common/use_case/refresh_user_page_use_case.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/weather/model/weather.dart';

import '../../../../mock/data/feed/use_case/mock_get_user_page_feeds_use_case.dart';
import '../../../../mock/data/user/use_case/mock_get_user_profile_use_case.dart';

void main() {
  group('RefreshUserPageUseCase 클래스', () {
    final MockGetUserProfileUseCase mockGetUserProfileUseCase =
        MockGetUserProfileUseCase();
    final MockGetUserPageFeedsUseCase mockGetUserPageFeedsUseCase =
        MockGetUserPageFeedsUseCase();

    final RefreshUserPageUseCase refreshUserPageUseCase =
        RefreshUserPageUseCase(
            getUserProfileUseCase: mockGetUserProfileUseCase,
            getUserPageFeedsUseCase: mockGetUserPageFeedsUseCase);

    final Map<String, dynamic> expectedParameterMap = {
      'email': 'qoophon@gmail.com',
      'createdAt': null,
      'limit': 20,
    };

    final expectProfile = UserProfile(
      email: 'qoophon@gmail.com',
      nickname: '김동혁',
      gender: 1,
      profileImagePath:
          'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
      feedCount: 0,
      createdAt: DateTime.parse('2024-05-01 13:27:00'),
    );

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

    setUp(() {
      mockGetUserProfileUseCase.initMockData();
      mockGetUserPageFeedsUseCase.initMockData();
    });

    group('execute() 메소드는', () {
      test(
          'mockGetUserProfileUseCase.execute(), '
          'mockGetUserPageFeedsUseCase.execute() 메소드를 각 1회 호출한다.', () async {
        const int expectCallCount = 1;

        await refreshUserPageUseCase.execute(
          email: expectedParameterMap['email'],
          createdAt: expectedParameterMap['createdAt'],
          limit: expectedParameterMap['limit'],
        );

        expect(mockGetUserProfileUseCase.executeCallCount, expectCallCount);
        expect(mockGetUserPageFeedsUseCase.executeCallCount, expectCallCount);
      });
      test(
          '전달 받은 인자를'
          'mockGetUserProfileUseCase.execute() 와 '
          'mockGetUserPageFeedsUseCase.execute() 메소드에 그대로 각각 전달한다.', () async {
        await refreshUserPageUseCase.execute(
          email: expectedParameterMap['email'],
          createdAt: expectedParameterMap['createdAt'],
          limit: expectedParameterMap['limit'],
        );

        expect(mockGetUserProfileUseCase.methodParameter,
            expectedParameterMap['email']);
        expect(mockGetUserPageFeedsUseCase.methodParameterMap,
            expectedParameterMap);
      });
      test(
          'mockGetUserProfileUseCase.execute() 와 '
          'mockGetUserPageFeedsUseCase.execute() 메소드를 호출하고 전달받은 반환값을 '
          'Map 형태로 감싸 반환한다.', () async {
        mockGetUserProfileUseCase.returnValue = expectProfile;
        mockGetUserPageFeedsUseCase.returnValue = expectFeedList;

        final expectReturnValue = {
          'userProfile': expectProfile,
          'feedList': expectFeedList,
        };

        final actualReturnValue = await refreshUserPageUseCase.execute(
          email: expectedParameterMap['email'],
          createdAt: expectedParameterMap['createdAt'],
          limit: expectedParameterMap['limit'],
        );

        expect(actualReturnValue, expectReturnValue);
      });
    });
  });
}
