import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/get_user_profile_use_case.dart';

import '../../../mock/data/user/repository/mock_user_profile_repository_impl.dart';

void main() {
  group('GetUserProfileUseCase 클래스', () {
    final mockUserProfileRepository = MockUserProfileRepositoryImpl();
    GetUserProfileUseCase useCase =
        GetUserProfileUseCase(userProfileRepository: mockUserProfileRepository);

    group('getDetailUserProfile 메서드는', () {
      setUp(() {
        mockUserProfileRepository.methodParameterMap.clear();
        mockUserProfileRepository.resetProfile();
      });

      test("'user@email.com'을 반환한다.", () async {
        // Given
        const String expectedResult = 'user@email.com';

        // When
        final UserProfile? result =
            await useCase.execute(email: expectedResult);

        // Then
        expect(result, null);
      });

      test('이메일에 해당하는 프로필이 있는 경우 해당 프로필을 반환한다.', () async {
        // Given
        String email = 'mock@email.com';
        UserProfile? expectedResult = UserProfile(
          email: 'mock@email.com',
          nickname: 'nickName',
          gender: 0,
          profileImagePath:
              'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-01 14:27:00'),
        );

        mockUserProfileRepository.addProfile(profile: expectedResult);

        // When
        final result = await useCase.execute(email: email);

        // expect
        expect(result, expectedResult);
      });
    });
  });
}
