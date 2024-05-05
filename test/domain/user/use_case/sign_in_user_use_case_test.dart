import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/use_case/sign_in_user_use_case.dart';

import '../../../mock/data/user/repository/mock_user_auth_repository_impl.dart';

void main() {
  final MockUserAuthRepositoryImpl mockUserAuthRepositoryImpl =
      MockUserAuthRepositoryImpl();

  final SignInUserUseCase signInUserUseCase =
      SignInUserUseCase(userAuthRepository: mockUserAuthRepositoryImpl);

  group('SignInUserUseCase 클래스', () {
    group('execute() 메소드는', () {
      test('UserAuthRepository.signIn() 메소드를 1회 호출한다.', () async {
        int expectCallCount = 1;

        final expectParameter = UserAuth(
          email: 'qoophon@gmail.com',
          password: 'password',
        );

        const expectReturnValue = true;
        mockUserAuthRepositoryImpl.returnValue = expectReturnValue;

        await signInUserUseCase.execute(userAuth: expectParameter);

        expect(mockUserAuthRepositoryImpl.signInCallCount, expectCallCount);
      });
      test('전달받은 인자를 그대로 UserAuthRepository.signIn() 로 전달한다.', () async {
        final expectParameter = UserAuth(
          email: 'qoophon@gmail.com',
          password: 'password',
        );

        const expectReturnValue = true;
        mockUserAuthRepositoryImpl.returnValue = expectReturnValue;

        await signInUserUseCase.execute(userAuth: expectParameter);

        expect(mockUserAuthRepositoryImpl.methodParameter, expectParameter);
      });
      test('UserAuthRepository.signIn() 로 반환받은 인자를 그대로 반환한다. ', () async {
        final expectParameter = UserAuth(
          email: 'qoophon@gmail.com',
          password: 'password',
        );

        const expectReturnValue = true;
        mockUserAuthRepositoryImpl.returnValue = expectReturnValue;

        final actualReturnValue =
            await signInUserUseCase.execute(userAuth: expectParameter);

        expect(actualReturnValue, expectReturnValue);
      });
    });
  });
}
