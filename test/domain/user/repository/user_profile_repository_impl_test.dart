import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/data/user/repository/user_profile_repository_impl.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_profile_repository.dart';

import '../../../mock/data/user/data_source/mock_remote_user_profile_data_source.dart';

void main() {
  group('UserProfileRepositoryImpl 클래스', () {
    final remoteUserProfileDataSource = MockRemoteUserProfileDataSourceImpl();
    final UserProfileRepository userProfileRepository =
        UserProfileRepositoryImpl(
            remoteUserProfileDataSource: remoteUserProfileDataSource);

    group('getMyProfile 메서드는', () {
      setUp(() {
        remoteUserProfileDataSource.initMockData();
      });

      test('remoteUserProfileDataSource.getUserProfile 메서드를 한 번 호출한다.',
          () async {
        // Given
        const int expectedCount = 1;
        UserProfile userProfile = UserProfile(
          email: 'test@email.com',
          nickname: 'test',
          gender: 0,
          profileImagePath:
              'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-01 13:27:00'),
        );

        remoteUserProfileDataSource.getUserProfileResult = userProfile;

        // When
        await userProfileRepository.getMyProfile();

        // Then
        expect(remoteUserProfileDataSource.getUserProfileMethodCallCount,
            expectedCount);
      });

      test(
          'remoteUserProfileDataSource.getUserProfile 메서드를 한 번 호출하고 유저 프로필을 반환한다.',
          () async {
        // Given
        const int expectedCount = 1;
        UserProfile expectedUserProfile = UserProfile(
          email: 'test@email.com',
          nickname: 'test',
          gender: 0,
          profileImagePath:
              'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-01 13:27:00'),
        );

        remoteUserProfileDataSource.getUserProfileResult = expectedUserProfile;

        // When
        final actualUserProfile = await userProfileRepository.getMyProfile();

        // Then
        expect(remoteUserProfileDataSource.getUserProfileMethodCallCount,
            expectedCount);
        expect(actualUserProfile, expectedUserProfile);
      });
    });

    group('getUserProfile 메서드는', () {
      setUp(() {
        remoteUserProfileDataSource.initMockData();
      });

      test('remoteUserProfileDataSource.getUserProfile 메서드를 한 번 호출한다.',
          () async {
        // Given
        const int expectedCount = 1;
        UserProfile userProfile = UserProfile(
          email: 'test@email.com',
          nickname: 'test',
          gender: 0,
          profileImagePath:
              'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-01 13:27:00'),
        );

        remoteUserProfileDataSource.getUserProfileResult = userProfile;

        // When
        await userProfileRepository.getUserProfile(email: userProfile.email);

        // Then
        expect(remoteUserProfileDataSource.getUserProfileMethodCallCount,
            expectedCount);
      });

      test(
          'remoteUserProfileDataSource.getUserProfile 메서드를 한 번 호출하고 유저 프로필을 반환한다.',
          () async {
        // Given
        const int expectedCount = 1;
        UserProfile expectedUserProfile = UserProfile(
          email: 'test@email.com',
          nickname: 'test',
          gender: 0,
          profileImagePath:
              'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-01 13:27:00'),
        );

        remoteUserProfileDataSource.getUserProfileResult = expectedUserProfile;

        // When
        final actualUserProfile = await userProfileRepository.getUserProfile(
            email: expectedUserProfile.email);

        // Then
        expect(remoteUserProfileDataSource.getUserProfileMethodCallCount,
            expectedCount);
        expect(actualUserProfile, expectedUserProfile);
      });
    });
  });
}
