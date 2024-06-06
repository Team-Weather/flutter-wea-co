import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/data/feed/repository/ootd_feed_repository_impl.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/weather/model/weather.dart';

import '../../../mock/data/feed/repository/mock_feed_repository_impl.dart';
import '../../../mock/data/file/repository/mock_file_repository_impl.dart';
import '../../../mock/data/user/repository/mock_user_profile_repository_impl.dart';

void main() {
  group('OotdFeedRepositoryImpl 클래스', () {
    final fileRepository = MockFileRepositoryImpl();
    final feedRepository = MockFeedRepositoryImpl();
    final userProfileRepository = MockUserProfileRepositoryImpl();
    final ootdFeedRepository = OotdFeedRepositoryImpl(
      fileRepository: fileRepository,
      feedRepository: feedRepository,
      userProfileRepository: userProfileRepository,
    );
    const String feedId = '1';

    final Weather mockWeather = Weather(
      temperature: 31,
      timeTemperature: DateTime.parse('2024-05-06'),
      code: 1,
      createdAt: DateTime.parse('2024-05-06'),
    );
    final Location mockLocation = Location(
      lat: 31.23,
      lng: 29.48,
      city: '서울시, 노원구',
      createdAt: DateTime.parse('2024-05-06'),
    );
    final mockFeed = Feed(
      id: null,
      imagePath: '',
      thumbnailImagePath: '',
      userEmail: 'test@email.com',
      description: 'This is a test feed',
      weather: mockWeather,
      seasonCode: 2,
      location: mockLocation,
      createdAt: DateTime.parse('2024-05-06'),
    );

    final mockUserProfile = UserProfile(
      email: 'email',
      nickname: 'nickname',
      gender: 1,
      profileImagePath: 'profileImagePath',
      feedCount: 0,
      createdAt: DateTime.parse('2024-05-06'),
    );

    setUp(() {
      fileRepository.initMockData();
      feedRepository.initMockData();
      userProfileRepository.resetCallCount();
      userProfileRepository.resetProfile();
      userProfileRepository.addMyProfile(profile: mockUserProfile);
    });

    group('saveOotdFeed 메서드는', () {
      test('피드를 저장하기 위해 FileRepository.saveOotdImage()를 한 번 호출한다.', () async {
        // Given
        const expectedCallCount = 1;

        // When
        await ootdFeedRepository.saveOotdFeed(feed: mockFeed);

        // Then
        expect(fileRepository.saveOotdImageCallCount, expectedCallCount);
      });

      test('피드를 저장하기 위해 FeedRepository.saveFeed()를 한 번 호출한다.', () async {
        // Given
        const expectedCallCount = 1;

        // When
        await ootdFeedRepository.saveOotdFeed(feed: mockFeed);

        // Then
        expect(feedRepository.saveFeedCallCount, expectedCallCount);
      });

      test(
          '파라미터로 받은 feed 에 FileRepository.saveOotdImage()로 받은 path 를 '
          '추가한 새로운 피드를 FeedRepository.saveFeed()에 전달한다.', () async {
        // Given
        const String path = '';
        fileRepository.saveOotdImageResult = [path, path];

        // 예상 값
        final expectedFeed = mockFeed.copyWith(imagePath: path);

        // When
        await ootdFeedRepository.saveOotdFeed(feed: mockFeed);

        // Then
        expect(feedRepository.feed, expectedFeed);
      });

      test(
          '유저 피드 카운트를 업데이트하기 위해 UserProfileRepository.getMyProfile()를 한 번 호출한다.',
          () async {
        // Given
        const expectedCallCount = 1;

        // When
        await ootdFeedRepository.saveOotdFeed(feed: mockFeed);

        // Then
        expect(userProfileRepository.getMyProfileCallCount, expectedCallCount);
      });

      test(
          '유저 피드 카운트를 업데이트하기 위해 UserProfileRepository.updateUserProfile()를 한 번 호출한다.',
          () async {
        // Given
        const expectedCallCount = 1;

        // When
        await ootdFeedRepository.saveOotdFeed(feed: mockFeed);

        // Then
        expect(userProfileRepository.updateUserProfileCallCount,
            expectedCallCount);
      });

      test(
          '가져온 유저 피드 카운트에 1을 더한 userProfile 을 '
          'UserProfileRepository.updateUserProfile()에 전달한다.', () async {
        // Given
        final expectedUseProfile =
            mockUserProfile.copyWith(feedCount: mockUserProfile.feedCount + 1);

        // When
        await ootdFeedRepository.saveOotdFeed(feed: mockFeed);

        // Then
        expect(userProfileRepository.methodParameterMap['updateUserProfile'],
            expectedUseProfile);
      });

      test(
          'FeedRepository.saveFeed(), UserProfileRepository.updateMyFeedCount()를 '
          '정상적으로 한번 호출했는지 확인한다.', () async {
        // Given
        const int expected = 1;

        // When
        await ootdFeedRepository.saveOotdFeed(feed: mockFeed);

        // Then
        expect(feedRepository.saveFeedCallCount, expected);
        expect(userProfileRepository.updateUserProfileCallCount, expected);
      });

      test(
          '파라미터로 전달받은 Feed의 id값이 있으면 수정하는 Feed로써 FeedRepository.saveFeed를 한번 호출한다.',
          () async {
        // Given
        const int expected = 1;

        // When
        await ootdFeedRepository.saveOotdFeed(feed: mockFeed.copyWith(id: '1'));

        // Then
        expect(feedRepository.saveFeedCallCount, expected);
      });

      test(
          '파라미터로 전달받은 Feed의 id값이 있으면 수정하는 Feed로써 FileRepository.saveOotdImage()를 호출하지 않는다.',
          () async {
        // Given
        const int expected = 0;

        // When
        await ootdFeedRepository.saveOotdFeed(feed: mockFeed.copyWith(id: '1'));

        // Then
        expect(fileRepository.saveImageCallCount, expected);
      });

      test(
          '파라미터로 전달받은 Feed의 id값이 있으면 수정하는 Feed로써 UserProfileRepository.getMyProfile()를 호출하지 않는다.',
          () async {
        // Given
        const int expected = 0;

        // When
        await ootdFeedRepository.saveOotdFeed(feed: mockFeed.copyWith(id: '1'));

        // Then
        expect(userProfileRepository.getMyProfileCallCount, expected);
      });
    });

    group('removeOotdFeed 메서드는', () {
      test('피드를 삭제하기 위해 FeedRepository.deleteFeed()를 한 번 호출한다.', () async {
        // Given
        const expectedCallCount = 1;

        // When
        await ootdFeedRepository.removeOotdFeed(id: feedId);

        // Then
        expect(feedRepository.getDeleteFeedCallCount, expectedCallCount);
      });

      test(
          '유저 피드 카운트를 업데이트하기 위해 UserProfileRepository.getMyProfile()를 한 번 호출한다.',
          () async {
        // Given
        const expectedCallCount = 1;

        // When
        await ootdFeedRepository.removeOotdFeed(id: feedId);

        // Then
        expect(userProfileRepository.getMyProfileCallCount, expectedCallCount);
      });

      test(
          '유저 피드 카운트를 업데이트하기 위해 UserProfileRepository.updateUserProfile()를 한 번 호출한다.',
          () async {
        // Given
        const expectedCallCount = 1;

        // When
        await ootdFeedRepository.removeOotdFeed(id: feedId);

        // Then
        expect(userProfileRepository.updateUserProfileCallCount,
            expectedCallCount);
      });

      test(
          '가져온 유저 피드 카운트에 1을 뺀 값을 UserProfileRepository.updateUserProfile()에 전달한다.',
          () async {
        // Given
        final expectedUserProfile =
            mockUserProfile.copyWith(feedCount: mockUserProfile.feedCount - 1);

        // When
        await ootdFeedRepository.removeOotdFeed(id: feedId);

        // Then
        expect(userProfileRepository.methodParameterMap['updateUserProfile'],
            expectedUserProfile);
      });

      test(
          'FeedRepository.deleteFeed(), UserProfileRepository.updateUserProfile()를 '
          '정상적으로 한번 호출했는지 확인한다.', () async {
        // Given
        const expected = 1;

        // When
        await ootdFeedRepository.removeOotdFeed(id: feedId);

        // Then
        expect(feedRepository.getDeleteFeedCallCount, expected);
        expect(userProfileRepository.updateUserProfileCallCount, expected);
      });
    });
  });
}
