import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/use_case/sign_in_user_use_case.dart';

import '../../../mock/data/user/repository/mock_user_auth_repository_impl.dart';

void main() {
  final MockUserAuthRepositoryImpl mockUserAuthRepositoryImpl =
      MockUserAuthRepositoryImpl();

  final SignInUserUseCase signInUserUseCase =
      SignInUserUseCase(userAuthRepository: mockUserAuthRepositoryImpl);

  setUp(() {
    mockUserAuthRepositoryImpl.initMockData();
  });

  group('SignInUserUseCase 클래스', () {
    group('execute() 메소드는', () {
      test('UserAuthRepository.signIn() 메소드를 1회 호출한다.', () async {
        int expectCallCount = 1;

        final expectParameter = UserAuth(
          email: 'qoophon@gmail.com',
          password: 'password',
        );

        await signInUserUseCase.execute(userAuth: expectParameter);

        expect(mockUserAuthRepositoryImpl.signInCallCount, expectCallCount);
      });
      test('전달받은 인자를 그대로 UserAuthRepository.signIn() 로 전달한다.', () async {
        final expectParameter = UserAuth(
          email: 'qoophon@gmail.com',
          password: 'password',
        );

        await signInUserUseCase.execute(userAuth: expectParameter);

        expect(mockUserAuthRepositoryImpl.methodParameter, expectParameter);
      });
      test('일치하는 유저가 없을시 false를 반환한다.', () async {
        final expectParameter = UserAuth(
          email: 'qoophon@gmail.com',
          password: 'password',
        );

        mockUserAuthRepositoryImpl.addUserAuth(
          UserAuth(
            email: 'qoophon@gmail.com',
            password: 'password1',
          ),
        );

        final actualReturnValue =
            await signInUserUseCase.execute(userAuth: expectParameter);

        expect(actualReturnValue, false);
      });
      test('일치하는 유저가 있을 시 true를 반환한다.', () async {
        final expectParameter = UserAuth(
          email: 'qoophon@gmail.com',
          password: 'password',
        );

        mockUserAuthRepositoryImpl.addUserAuth(
          UserAuth(
            email: 'qoophon@gmail.com',
            password: 'password',
          ),
        );

        final actualReturnValue =
            await signInUserUseCase.execute(userAuth: expectParameter);

        expect(actualReturnValue, true);
      });
    });
  });
}
