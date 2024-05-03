import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/common/file/use_case/undo_edit_cropped_image_use_case.dart';

import '../../../mock/data/common/repository/mock_file_repository_impl.dart';

void main() {
  group('UndoEditCroppedImageUseCase 클래스', () {
    final mockFileRepository = MockFileRepositoryImpl();
    final UndoEditCroppedImageUseCase useCase =
        UndoEditCroppedImageUseCase(fileRepository: mockFileRepository);

    setUp(() => mockFileRepository.initMockData());

    group('execute 메서드는', () {
      test('FileRepository.removeCroppedImage()을 한번 호출한다.', () async {
        // Given
        const expectCount = 1;

        // When
        await useCase.execute();

        // Then
        expect(mockFileRepository.removeCroppedImageCallCount, expectCount);
      });

      test('FileRepository.removeCroppedImage()을 호출하고 반환 받은 값을 그대로 반환한다.',
          () async {
        // Given
        bool expectResult = false;
        mockFileRepository.fakeSaveDataResult = expectResult;

        // When
        final result = await mockFileRepository.removeCroppedImage();

        // Then
        expect(result, expectResult);
      });
    });
  });
}
