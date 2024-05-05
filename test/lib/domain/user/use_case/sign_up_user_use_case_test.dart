import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/sign_up_user_use_case.dart';
import '../../../../mock/data/user/repository/mock_user_repository_impl.dart';

void main() {
  group('SignUpUserUseCase 클래스', () {
    group('execute 메서드는', () {
      test('UserRepository.signUpUser()를 한번 호출한다.', () async {
        // Given
        UserAuth userAuth =
            UserAuth(email: 'test@email.com', password: 'password');
        final userEmail = userAuth.email;
        UserProfile userProfile = UserProfile(
          email: userEmail,
          nickname: 'nickname',
          gender: 1,
          profileImagePath: '',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-04'),
          deletedAt: DateTime.parse('2024-05-04'),
        );

        // When
        final signUpUserUseCase =
            SignUpUserUseCase(userRepository: MockUserRepositoryImpl());
        await signUpUserUseCase.execute(userAuth, userProfile, userEmail);

        // Then
        expect(
            MockUserRepositoryImpl().signUp(userAuth, userProfile, userEmail),
            completion(true));
      });
    });
  });
}
