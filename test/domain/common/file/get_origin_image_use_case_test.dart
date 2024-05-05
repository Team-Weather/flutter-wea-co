import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/common/file/use_case/get_origin_image_use_case.dart';

import '../../../mock/data/common/file/repository/mock_file_repository_impl.dart';

void main() {
  group('GetOriginImageUseCase 클래스', () {
    final mockFileRepository = MockFileRepositoryImpl();
    final GetOriginImageUseCase useCase =
    GetOriginImageUseCase(fileRepository: mockFileRepository);

    setUp(() => mockFileRepository.initMockData());

    group('execute 메서드는', () {
      test('FileRepository.getOriginImage()을 한번 호출한다.', () async {
        // Given
        const expectCount = 1;

        // When
        await useCase.execute();

        // Then
        expect(mockFileRepository.getOriginImageCallCount, expectCount);
      });

      test('FileRepository.getOriginImage()을 호출하고 반환 받은 값을 그대로 반환한다.', () async {
        // Given
        File? expectResult;
        mockFileRepository.getOriginImageResult = expectResult;

        // When
        final result = await mockFileRepository.getOriginImage();

        // Then
        expect(result, expectResult);
      });
    });
  });
}