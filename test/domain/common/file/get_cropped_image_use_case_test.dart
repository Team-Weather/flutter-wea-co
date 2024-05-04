import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/common/file/use_case/get_cropped_image_use_case.dart';

import '../../../mock/data/common/repository/mock_file_repository_impl.dart';

void main() {
  group('GetCroppedImageUseCase 클래스', () {
    final mockFileRepository = MockFileRepositoryImpl();
    final GetCroppedImageUseCase useCase =
        GetCroppedImageUseCase(fileRepository: mockFileRepository);

    setUp(() => mockFileRepository.initMockData());

    group('execute 메서드는', () {
      test('FileRepository.getCroppedImage()을 한번 호출한다.', () async {
        // Given
        const expectCount = 1;

        // When
        await useCase.execute(data: [1, 2, 3]);

        // Then
        expect(mockFileRepository.getCroppedImageCallCount, expectCount);
      });
    });
  });
}