import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/data/weather/data_source/remote_data_source/remote_weather_background_image_data_source.dart';
import 'package:weaco/data/weather/data_source/remote_data_source/remote_weather_background_image_data_source_impl.dart';

void main() {
  group('RemoteWeatherBackgroundImageDataSourceImpl 클래스', () {
    final fakeFirestore = FakeFirebaseFirestore();
    final RemoteWeatherBackgroundImageDataSource dataSource =
        RemoteWeatherBackgroundImageDataSourceImpl(firestore: fakeFirestore);

    group(
        'getWeatherBackgroundImageList 메서드는 FirestoreDatabase의 weather_background_images 컬렉션의 모든 문서를 요청하여 반환한다.',
        () {
      test('', () async {
        // Given
        final codes = [0, 1];
        final imagePaths = [
          'https://health.chosun.com/2024012201607_0.jpg',
          'https://health.chosun.com/2024012201607_1.jpg'
        ];
        for (int idx = 0; idx < imagePaths.length; idx++) {
          fakeFirestore
              .collection('weather_background_images')
              .add({'code': codes[idx], 'image_path': imagePaths[idx]});
        }

        // When
        final result = await dataSource.getWeatherBackgroundImageList();

        // Then
        expect(result[0].imagePath, imagePaths[0]);
        expect(result[1].imagePath, imagePaths[1]);
      });
    });
  });
}
