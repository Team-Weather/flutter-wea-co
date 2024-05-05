import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/sign_up_user_use_case.dart';
import '../../../../mock/data/user/repository/mock_user_repository_impl.dart';

void main() {
  group('SignUpUserUseCase 클래스', () {
    final mockUserRepository = MockUserRepositoryImpl();
    final SignUpUserUseCase signUpUserUseCase =
        SignUpUserUseCase(userRepository: mockUserRepository);
    group('execute 메서드는', () {
      test('UserRepository.signUpUser()를 호출하여 회원가입에 성공하면 true를 반환한다.',
          () async {
        MockUserRepositoryImpl().initMockData();

        // Given
        const existingEmail = 'existingUser@email.com';
        const newEmail = 'newUser@email.com';
        final existingUserAuth =
            UserAuth(email: existingEmail, password: 'password');
        final existingUserProfile = UserProfile(
          email: existingUserAuth.email,
          nickname: 'nickname',
          gender: 1,
          profileImagePath: 'profileImagePath',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-01'),
        );
        final newUserAuth = UserAuth(email: newEmail, password: 'password');
        final newUserProfile = UserProfile(
          email: newUserAuth.email,
          nickname: 'nickname',
          gender: 1,
          profileImagePath: 'profileImagePath',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-05'),
        );

        // When
        signUpUserUseCase.execute(
            userAuth: existingUserAuth, userProfile: existingUserProfile);
        if (!await MockUserRepositoryImpl()
            .isRegistered(email: newUserAuth.email)) {
          bool success = await MockUserRepositoryImpl()
              .signUp(userAuth: newUserAuth, userProfile: newUserProfile);

          // Then
          expect(success, true);
        }
      });

      test('UserRepository.signUpUser()를 호출하여 회원가입에 실패하면 false를 반환한다.',
          () async {
        MockUserRepositoryImpl().initMockData();

        // Given
        const existingEmail = 'existingUser@email.com';
        const newEmailDuplicated = 'existingUser@email.com';
        final existingUserAuth =
            UserAuth(email: existingEmail, password: 'password');
        final existingUserProfile = UserProfile(
          email: existingUserAuth.email,
          nickname: 'nickname',
          gender: 1,
          profileImagePath: 'profileImagePath',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-01'),
        );
        final newUserAuth =
            UserAuth(email: newEmailDuplicated, password: 'password');
        final newUserProfileDuplicated = UserProfile(
          email: newUserAuth.email,
          nickname: 'nickname',
          gender: 1,
          profileImagePath: 'profileImagePath',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-05'),
        );

        // When
        signUpUserUseCase.execute(
            userAuth: existingUserAuth, userProfile: existingUserProfile);

        if (!await MockUserRepositoryImpl()
            .isRegistered(email: newUserAuth.email)) {
          bool fail = await MockUserRepositoryImpl().signUp(
              userAuth: newUserAuth, userProfile: newUserProfileDuplicated);

          // Then
          expect(fail, true);
        }
      });
    });
  });
}
