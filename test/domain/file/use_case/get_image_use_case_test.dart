import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/file/use_case/get_image_use_case.dart';

import '../../../mock/data/file/repository/mock_file_repository_impl.dart';

void main() {
  group('GetImageUseCase 클래스', () {
    final mockFileRepository = MockFileRepositoryImpl();
    final GetImageUseCase useCase =
        GetImageUseCase(fileRepository: mockFileRepository);

    setUp(() => mockFileRepository.initMockData());

    group('execute 메서드는', () {
      test('FileRepository.getImage()을 한번 호출한다.', () async {
        // Given
        const expectCount = 1;

        // When
        await useCase.execute(isOrigin: true);

        // Then
        expect(mockFileRepository.getImageCallCount, expectCount);
      });
    });
  });
}