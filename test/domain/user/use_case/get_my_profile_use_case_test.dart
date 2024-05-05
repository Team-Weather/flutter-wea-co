import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/get_my_profile_use_case.dart';
import '../../../mock/data/user/repository/mock_user_profile_repository_impl.dart';

void main() {
  group('GetMyPageUserProfileUseCase 클래스', () {
    final mockUserProfileRepository = MockUserProfileRepositoryImpl();
    final GetMyPageUserProfileUseCase useCase = GetMyPageUserProfileUseCase(
        userProfileRepository: mockUserProfileRepository);

    setUp(() {
      mockUserProfileRepository.resetCallCount();
      mockUserProfileRepository.resetProfile();
    });

    group('execute 메서드는', () {
      test('UserProfileRepository.getMyProfile()을 한번 호출한다.', () async {
        // Given
        const expectCount = 1;

        // When
        await useCase.execute();

        // Then
        expect(mockUserProfileRepository.getMyProfileCallCount, expectCount);
      });

      test('UserProfileRepository.getMyProfile()를 호출하고 반환 받은 값을 그대로 반환한다.',
          () async {
        // Given
        const validEmail = 'abcd@gmail.com';
        final expectProfile = UserProfile(
            email: validEmail,
            nickname: '테스트',
            gender: 1,
            profileImagePath:
                'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
            feedCount: 0,
            createdAt: DateTime.parse('2024-05-01 13:27:00'));
        mockUserProfileRepository.addMyProfile(profile: expectProfile);

        // When
        final profile = await useCase.execute();

        // Then
        expect(profile, expectProfile);
      });
    });
  });
}
