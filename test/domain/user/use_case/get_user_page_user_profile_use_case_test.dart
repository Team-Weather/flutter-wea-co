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

    setUp(() {
      mockUserProfileRepository.getUserProfileCallCount = 0;
      mockUserProfileRepository.methodParameterMap.clear();
      mockUserProfileRepository.resetProfile();
    });

    group('execute 메서드는', () {
      test('UserProfileRepository.getUserProfile()을 한번 호출한다.', () async {
        // Given
        const expectCount = 1;
        const email = 'hoogom87@gmail.com';

        // When
        await useCase.execute(userEmail: email);

        // Then
        expect(mockUserProfileRepository.getUserProfileCallCount, expectCount);
      });

      test('인자로 받은 필터링 조건을 UserProfileRepository.getUserProfile()에 그대로 전달한다.', ()  async {
        // Given
        const userEmail = 'hoogom87@gmail.com';

        // When
        await useCase.execute(userEmail: userEmail);

        // Then
        expect(mockUserProfileRepository.methodParameterMap['email'], userEmail);
      });

      test('UserProfileRepository.getUserProfile()를 호출하고 반환 받은 값을 그대로 반환한다.', () async {
        // Given
        const expectNullProfile = null;
        const invalidEmail = 'hoogom88@gmail.com';
        const validEmail = 'hoogom87@gmail.com';
        final expectProfile = UserProfile(email: validEmail,
            nickname: '후곰',
            gender: 1,
            profileImagePath: 'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
            feedCount: 0,
            createdAt: DateTime.parse('2024-05-01 13:27:00'));
        mockUserProfileRepository.addProfile(profile: expectProfile);

        // When
        final nullProfile = await useCase.execute(userEmail: invalidEmail);
        final profile = await useCase.execute(userEmail: validEmail);

        // Then
        expect(nullProfile, expectNullProfile);
        expect(profile, expectProfile);
      });
    });
  });
}
