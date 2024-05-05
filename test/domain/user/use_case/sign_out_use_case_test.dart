import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/user/use_case/sign_out_use_case.dart';

import '../../../mock/data/user/repository/mock_user_auth_repository_impl.dart';

void main() {
  group('SignOutUseCase 클래스', () {
    final userAuthRepository = MockUserAuthRepositoryImpl();
    final SignOutUseCase useCase =
        SignOutUseCase(userAuthRepository: userAuthRepository);

    group('signOut 메서드는', () {
      setUp(() => userAuthRepository.initMockData());

      test('회원 탈퇴에 실패한다.', () async {
        // Given
        const bool expectedResult = false;
        userAuthRepository.isSignOut = expectedResult;

        // When
        final result = await useCase.execute();

        // Then
        expect(result, expectedResult);
      });

      test('회원 탈퇴에 성공한다.', () async {
        // Given
        const bool expectedResult = true;
        userAuthRepository.isSignOut = expectedResult;

        // When
        final result = await useCase.execute();

        // Then
        expect(result, expectedResult);
      });
    });
  });
}
