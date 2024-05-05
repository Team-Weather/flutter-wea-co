import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/user/use_case/log_out_setting_use_case.dart';

import '../../../mock/data/user/repository/mock_user_repository_impl.dart';


void main() {
  group('LogOutSettingUseCase 클래스', () {
    final userRepository = MockUserRepositoryImpl();
    final LogOutSettingUseCase useCase =
        LogOutSettingUseCase(userRepository: userRepository);

    setUp(() => userRepository.initMockData());

    group('logOutSetting 메서드는', () {
      test('로그아웃 실패를 반환한다.', () async {
        // Given
        userRepository.isLoggedOut = false;
        final expectedResult = await userRepository.logOut();

        // When
        final actual = await useCase.execute();

        // Then
        expect(actual, expectedResult);
      });

      test('로그아웃 성공을 반환한다.', () async {
        // Given
        userRepository.isLoggedOut = true;
        final expectedResult = await userRepository.logOut();

        // When
        final actual = await useCase.execute();

        // Then
        expect(actual, expectedResult);
      });
    });
  });
}
