import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/common/use_case/save_cropped_image_use_case.dart';
import '../../../mock/data/feed/repository/mock_image_repository_impl.dart';

void main() {
  group('SaveCroppedImageUseCase 클래스', () {
    final mockImageRepository = MockImageRepositoryImpl();
    final SaveCroppedImageUseCase useCase =
        SaveCroppedImageUseCase(imageRepository: mockImageRepository);

    group('execute 메서드는', () {
      test('saveCroppedImage 메서드를 호출하여 이미지를 저장한다.', () async {
        // Given
        final data = [1, 2, 3, 4];

        // When
        final result = await useCase.execute(data: data);

        // Then
        expect(result, true);
      });
    });
  });
}