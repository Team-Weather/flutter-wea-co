import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/user/data_source/remote_user_profile_data_source.dart';
import 'package:weaco/domain/user/data_source/remote_user_profile_date_source_impl.dart';
import 'package:weaco/domain/user/model/user_profile.dart';

void main() {
  final instance = FakeFirebaseFirestore();
  final RemoteUserProfileDataSource dataSource =
      RemoteUserProfileDataSourceImpl(firestore: instance);

  group(
    'RemoteUserProfileDataSource 클래스',
    () {
      test('saveUserProfile()은 firebase storage에 파라미터로 받은 유저 프로필 정보를 저장한다.',
          () async {
        // Given
        final expectedUserProfile = UserProfile(
          email: 'test@gmail.com',
          nickname: '테스트',
          gender: 1,
          profileImagePath:
              'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-01 13:27:00'),
        );

        // When
        final bool res =
            await dataSource.saveUserProfile(userProfile: expectedUserProfile);

        // Then
        expect(res, true);
      });
      test(
          'getUserProfile()은 firebase storage에서 파라미터로 받은 이메일과 동일한 유저 프로필 정보를 반환한다.',
          () async {
        // Given
        await instance.collection('user_profiles').add({
          'created_at': '2024-05-01 13:27:00',
          'deleted_at': null,
          'email': 'hoogom87@gmail.com',
          'feed_count': 0,
          'gender': 1,
          'nickname': '호구몬',
          'profile_image_path':
              'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg'
        });

        // When
        final UserProfile res =
            await dataSource.getUserProfile(email: 'hoogom87@gmail.com');

        final expectProfile = UserProfile(
          email: 'hoogom87@gmail.com',
          nickname: '호구몬',
          gender: 1,
          profileImagePath:
              'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
          feedCount: 0,
          createdAt: DateTime.parse('2024-05-01 13:27:00'),
          deletedAt: null,
        );

        // Then
        expect(res, expectProfile);
      });

      test(
        'updateUserProfile()은 firebase storage에서 파라미터로 받은 프로필로 동일한 유저 프로필 정보를 업데이트한다.',
        () async {
          // Given
          await instance.collection('user_profiles').add({
            'created_at': '2024-05-01 13:27:00',
            'deleted_at': null,
            'email': 'test@gmail.com',
            'feed_count': 0,
            'gender': 1,
            'nickname': '호구몬',
            'profile_image_path':
                'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg'
          });

          final editedUserProfile = UserProfile(
            email: 'test@gmail.com',
            nickname: '테스트123',
            gender: 1,
            profileImagePath:
                'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
            feedCount: 0,
            createdAt: DateTime.parse('2024-05-01 13:27:00'),
          );

          // When
          final bool res = await dataSource.updateUserProfile(
              userProfile: editedUserProfile);

          // Then
          expect(res, true);
        },
      );
      test(
        'removeUserProfile()은 firebase storage에서 파라미터로 받은 이메일과 동일한 유저 프로필 정보를 삭제한다.',
        () async {
          // Given
          await instance.collection('user_profiles').add({
            'created_at': '2024-05-01 13:27:00',
            'deleted_at': null,
            'email': 'test@gmail.com',
            'feed_count': 0,
            'gender': 1,
            'nickname': '호구몬',
            'profile_image_path':
                'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg'
          });

          const targetEmail = 'test@gmail.com';

          // When
          final bool res =
              await dataSource.removeUserProfile(email: targetEmail);

          // Then
          expect(res, true);
        },
      );
    },
  );
}
