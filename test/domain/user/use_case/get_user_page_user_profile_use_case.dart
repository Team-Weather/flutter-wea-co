import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/get_user_page_user_profile_use_case.dart';
import '../../../mock/data/user/repository/mock_user_profile_repository_impl.dart';

void main() {
  group('GetUserPageUserProfileUseCase 클래스', () {
    final mockUserProfileRepository = MockUserProfileRepositoryImpl();
    final GetUserPageUserProfileUseCase useCase =
        GetUserPageUserProfileUseCase(
            userProfileRepository: mockUserProfileRepository);
    
    group('getUserProfile 메서드는', () {
      test('UserProfileRepository.getUserProfile()을 한번 호출한다.', () async {
        // Given
        final expectCount = 1;
        final email = 'hoogom87@gmail.com';

        // When
        await useCase.execute(userEmail: email);

        // Then
        expect(mockUserProfileRepository.getUserProfileCallCount, expectCount);
      });

      test('이메일에 해당하는 프로필이 없는 경우 null을 반환한다.', () async {
        // Given
        final expectProfile = null;
        final invalidEmail = 'hoogom88@gmail.com';

        // When
        final profile = await useCase.execute(userEmail: invalidEmail);

        // Then
        expect(profile, expectProfile);
      });

      test('이메일에 해당하는 프로필이 있는 경우 해당 프로필을 반환한다.', () async {
        // Given
        final validEmail = 'hoogom87@gmail.com';
        final userProfile = UserProfile(email: 'hoogom87@gmail.com',
            nickname: '후곰',
            gender: 1,
            profileImagePath: 'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
            feedCount: 0,
            createdAt: DateTime.parse('2024-05-01 13:27:00'));
        mockUserProfileRepository.addProfile(profile: userProfile);

        // When
        final profile = await useCase.execute(userEmail: validEmail);

        // Then
        expect(profile, userProfile);
      });
    });
  });
}
