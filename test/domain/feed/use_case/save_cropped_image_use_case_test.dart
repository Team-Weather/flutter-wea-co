import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/common/use_case/save_cropped_image_use_case.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

import '../../../mock/data/feed/repository/mock_image_repository_impl.dart';

void main() {
  group('SaveCroppedImageUseCase 클래스', () {
    final mockImageRepository = MockImageRepositoryImpl();
    final SaveCroppedImageUseCase useCase =
        SaveCroppedImageUseCase(mockImageRepository);

    group('execute 메서드는', () {
      test('saveCroppedImage()을 호출하면 Feed Image를 반환해야 합니다.', () async {
        // Given
        String testImagePath = 'testImagePath';
        final Feed testFeed =Feed(
          id: '1',
          imagePath: testImagePath,
          userEmail: 'test@email.com',
          description: 'description',
          weather: Weather(
            temperature: 1.0,
            timeTemperature: DateTime.now(),
            code: 1,
            createdAt: DateTime.now(),
          ),
          seasonCode: 1,
          location: Location(
            lat: 1.0,
            lng: 1.0,
            city: '서울시, 노원구',
            createdAt: DateTime.now(),
          ),
          createdAt: DateTime.now(),
        );

        // When
        final result = await useCase.execute(testImagePath);

        // Then
        expect(result.id, testFeed.id);
        expect(testFeed.imagePath, testImagePath);
      });
    });
  });
}