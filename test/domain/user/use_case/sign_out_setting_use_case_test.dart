import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/sign_out_setting_use_case.dart';

import '../../../mock/data/user/repository/mock_sign_out_setting_case_repository_impl.dart';

void main() {
  group('SignOutSettingUseCase 클래스', () {
    final mockSignOutSettingRepositoryImpl = MockSignOutSettingRepositoryImpl();
    final SignOutSettingUseCase useCase = SignOutSettingUseCase(
        userAuthRepository: mockSignOutSettingRepositoryImpl);

    group('signOutSetting 메서드는', () {
      setUp(() => mockSignOutSettingRepositoryImpl.initMockData());

      test('유저 정보가 없을 경우, 회원 탈퇴에 실패한다.', () async {
        // Given
        const bool expectedResult = false;
        String email = 'wrong@email.com';

        // When
        final result = await useCase.execute(email: email);

        // Then
        expect(result, expectedResult);
      });

      test('유저 정보가 일치 하지 않을 경우, 회원 탈퇴에 실패한다.', () async {
        // Given
        const bool expectedResult = false;
        String email = 'wrong@email.com';
        UserProfile? profile = UserProfile(
          email: 'mock@email.com',
          nickname: 'nickName',
          gender: 0,
          profileImagePath:
              'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-01 14:27:00'),
        );

        mockSignOutSettingRepositoryImpl.addProfile(profile: profile);

        // When
        final result = await useCase.execute(email: email);

        // Then
        expect(result, expectedResult);
      });

      test('유저 정보가 일치할 경우, 회원 탈퇴에 성공한다.', () async {
        // Given
        const bool expectedResult = true;
        String email = 'mock@email.com';
        UserProfile? profile = UserProfile(
          email: 'mock@email.com',
          nickname: 'nickName',
          gender: 0,
          profileImagePath:
          'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-01 14:27:00'),
        );

        mockSignOutSettingRepositoryImpl.addProfile(profile: profile);

        // When
        final result = await useCase.execute(email: email);

        // Then
        expect(result, expectedResult);
      });
    });
  });
}
