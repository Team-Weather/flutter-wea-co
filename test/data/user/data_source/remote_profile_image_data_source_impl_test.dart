import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/data/user/data_source/remote_profile_image_data_source.dart';
import 'package:weaco/data/user/data_source/remote_profile_image_data_source_impl.dart';

void main() {
  group('RemoteProfileImageDataSourceImpl 클래스', () {
    final fakeFirestore = FakeFirebaseFirestore();
    final RemoteProfileImageDataSource dataSource =
        RemoteProfileImageDataSourceImpl(firestore: fakeFirestore);

    group(
        'getProfileImageList 메서드는 FirestoreDatabase의 profile_images 컬렉션의 모든 문서를 요청하여 반환한다.',
        () {
      test('', () async {
        // Given
        final imageList = [
          'https://health.chosun.com/2024012201607_0.jpg',
          'https://health.chosun.com/2024012201607_1.jpg'
        ];
        for (var path in imageList) {
          fakeFirestore.collection('profile_images').add({'image_path': path});
        }

        // When
        final result = await dataSource.getProfileImageList();

        // Then
        expect(result[0].imagePath, imageList[0]);
        expect(result[1].imagePath, imageList[1]);
      });
    });
  });
}
