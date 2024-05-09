import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/data/user/repository/user_auth_%20repository_impl.dart';
import 'package:weaco/domain/user/model/user_auth.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_auth_repository.dart';

import '../../../mock/data/user/data_source/mock_remote_user_profile_data_source.dart';
import '../../../mock/data/user/data_source/mock_user_auth_data_source.dart';

void main() {
  final MockUserAuthDataSourceImpl userAuthDataSource =
      MockUserAuthDataSourceImpl();
  final MockRemoteUserProfileDataSourceImpl userProfileDataSource =
      MockRemoteUserProfileDataSourceImpl();

  final UserAuthRepository userAuthRepository = UserAuthRepositoryImpl(
    userAuthDataSource: userAuthDataSource,
    remoteUserProfileDataSource: userProfileDataSource,
  );

  final userAuth = UserAuth(
    email: 'qoophon@gmail.com',
    password: 'password',
  );
  final userProfile = UserProfile(
    email: 'qoophon@gmail.com',
    nickname: '김동혁',
    gender: 1,
    profileImagePath: '/test/assets/image.jpg',
    feedCount: 0,
    createdAt: DateTime(2024, 05, 09),
  );

  group('UserAuthRepositoryImpl 클래스', () {
    setUp(() {
      userAuthDataSource.initMockData();
      userProfileDataSource.initMockData();
    });

    group('signUp() 메소드는', () {
      test(
          'UserAuthDataSource.signUp(),'
          'RemoteUserProfileDataSource.saveUserasync Profile() 메소드를'
          '1회씩 호출한다.', () async {
        // given
        int expectCallCount = 1;

        // when
        await userAuthRepository.signUp(
          userAuth: userAuth,
          userProfile: userProfile,
        );

        // then
        expect(userAuthDataSource.signUpCallCount, expectCallCount);
        expect(userProfileDataSource.methodCallCount, expectCallCount);
      });

      test(
          '인자로 받은 값을 각각 '
          'UserAuthDataSource.signUp(),'
          'RemoteUserProfileDataSource.saveUserasync Profile() 메소드에 그대로 전달한다.',
          () async {
        // given
        final expectUserAuth = userAuth.copyWith();
        final expectUserProfile = userProfile.copyWith();

        final expectUserAuthParameter = {
          'email': expectUserAuth.email,
          'password': expectUserAuth.password,
        };

        // when
        await userAuthRepository.signUp(
          userAuth: expectUserAuth,
          userProfile: expectUserProfile,
        );

        // then
        expect(userAuthDataSource.methodParameter, expectUserAuthParameter);
        expect(userProfileDataSource.methodUserProfileParameter,
            expectUserProfile);
      });

      test('회원가입이 성공했을 때 true 를 반환한다.', () async {
        // given
        final expectUserAuth = userAuth.copyWith();
        final expectUserProfile = userProfile.copyWith();

        userAuthDataSource.returnValue = true;
        userProfileDataSource.isSaved = true;

        // when
        final actualResult = await userAuthRepository.signUp(
          userAuth: expectUserAuth,
          userProfile: expectUserProfile,
        );

        // then
        expect(actualResult, true);
      });
      test('회원가입이 성공했을 때 false 를 반환한다.', () async {
        // given
        final expectUserAuth = userAuth.copyWith();
        final expectUserProfile = userProfile.copyWith();

        userAuthDataSource.returnValue = false;

        // when
        final actualResult = await userAuthRepository.signUp(
          userAuth: expectUserAuth,
          userProfile: expectUserProfile,
        );

        // then
        expect(actualResult, false);
      });
    });

    group('signIn() 메소드는', () {
      test('UserAuthDataSource.signIn() 메소드를 1회 호출한다.', () async {
        // given
        int expectCallCount = 1;

        // when
        await userAuthRepository.signIn(
          userAuth: userAuth,
        );

        // then
        expect(userAuthDataSource.signInCallCount, expectCallCount);
      });

      test('인자로 받은 값을 UserAuthDataSource.signIn() 메소드에 그대로 전달한다.', () async {
        // given
        final expectUserAuth = userAuth.copyWith();

        final expectUserAuthParameter = {
          'email': expectUserAuth.email,
          'password': expectUserAuth.password,
        };

        // when
        await userAuthRepository.signIn(
          userAuth: expectUserAuth,
        );

        // then
        expect(userAuthDataSource.methodParameter, expectUserAuthParameter);
      });

      test('로그인이 성공했을 때 true 를 반환한다.', () async {
        // given
        final expectUserAuth = userAuth.copyWith();
        final expectUserProfile = userProfile.copyWith();

        userAuthDataSource.returnValue = true;

        // when
        final actualResult = await userAuthRepository.signIn(
          userAuth: expectUserAuth,
        );

        // then
        expect(actualResult, true);
      });

      test('로그인이 성공했을 때 false 를 반환한다.', () async {
        // given
        final expectUserAuth = userAuth.copyWith();
        final expectUserProfile = userProfile.copyWith();

        userAuthDataSource.returnValue = false;

        // when
        final actualResult = await userAuthRepository.signIn(
          userAuth: expectUserAuth,
        );

        // then
        expect(actualResult, false);
      });
    });

    group('logOut() 메소드는', () {
      test('UserAuthDataSource.logOut() 메소드를 1회 호출한다.', () async {
        // given
        int expectCallCount = 1;

        // when
        await userAuthRepository.logOut();

        // then
        expect(userAuthDataSource.logOutCallCount, expectCallCount);
      });

      test('로그아웃이 성공했을 때 true 를 반환한다.', () async {
        // given
        userAuthDataSource.returnValue = true;

        // when
        final actualResult = await userAuthRepository.logOut();

        // then
        expect(actualResult, true);
      });

      test('로그아웃이 성공했을 때 false 를 반환한다.', () async {
        // given
        userAuthDataSource.returnValue = false;

        // when
        final actualResult = await userAuthRepository.logOut();

        // then
        expect(actualResult, false);
      });
    });

    group('signOut() 메소드는', () {
      test('UserAuthDataSource.signOut() 메소드를 1회 호출한다.', () async {
        // given
        int expectCallCount = 1;

        // when
        await userAuthRepository.signOut();

        // then
        expect(userAuthDataSource.signOutCallCount, expectCallCount);
      });

      test('회원탈퇴가 성공했을 때 true 를 반환한다.', () async {
        // given
        userAuthDataSource.returnValue = true;

        // when
        final actualResult = await userAuthRepository.signOut();

        // then
        expect(actualResult, true);
      });

      test('회원탈퇴가 성공했을 때 false 를 반환한다.', () async {
        // given
        userAuthDataSource.returnValue = false;

        // when
        final actualResult = await userAuthRepository.signOut();

        // then
        expect(actualResult, false);
      });
    });
  });
}
