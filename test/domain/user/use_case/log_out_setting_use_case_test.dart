import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/user/use_case/log_out_use_case.dart';

import '../../../mock/data/user/repository/mock_user_auth_repository_impl.dart';


void main() {
  group('LogOutUseCase 클래스', () {
    final userAuthRepository = MockUserAuthRepositoryImpl();
    final LogOutUseCase useCase =
        LogOutUseCase(userAuthRepository: userAuthRepository);

    setUp(() => userAuthRepository.initMockData());

    group('logOut 메서드는', () {
      test('로그아웃 실패를 반환한다.', () async {
        // Given
        userAuthRepository.isLogOut = false;
        final expectedResult = await userAuthRepository.logOut();

        // When
        final actual = await useCase.execute();

        // Then
        expect(actual, expectedResult);
      });

      test('로그아웃 성공을 반환한다.', () async {
        // Given
        userAuthRepository.isLogOut = true;
        final expectedResult = await userAuthRepository.logOut();

        // When
        final actual = await useCase.execute();

        // Then
        expect(actual, expectedResult);
      });
    });
  });
}
