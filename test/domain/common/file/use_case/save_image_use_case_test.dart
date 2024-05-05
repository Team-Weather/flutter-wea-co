import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/common/file/use_case/save_image_use_case.dart';

import '../../../../mock/data/common/file/repository/mock_file_repository_impl.dart';

void main() {
  group('SaveImageUseCase 클래스', () {
    final mockFileRepository = MockFileRepositoryImpl();
    final SaveImageUseCase useCase =
    SaveImageUseCase(fileRepository: mockFileRepository);

    setUp(() => mockFileRepository.initMockData());

    group('execute 메서드는', () {
      test('FileRepository.saveImage()을 한번 호출한다.', () async {
        // Given
        const expectCount = 1;
        File data = File('flutter-wea-co\\test\\mock\\assets\\test_file.txt');

        // When
        await useCase.execute(file: data, isOrigin: true);

        // Then
        expect(mockFileRepository.saveImageCallCount, expectCount);
      });

      test('인자로 data를 FileRepository.saveImage()에 그대로 전달한다.', () async {
        // Given
        File data = File('flutter-wea-co\\test\\mock\\assets\\test_file.txt');

        // When
        await useCase.execute(file: data, isOrigin: true);

        // Then
        expect(mockFileRepository.methodParameterMap['data'], data);
      });

      test('FileRepository.saveImage()을 호출하고 반환 받은 값을 그대로 반환한다.', () async {
        // Given
        File data = File('flutter-wea-co\\test\\mock\\assets\\test_file.txt');
        bool expectResult = false;
        mockFileRepository.saveImageResult = expectResult;

        // When
        final result = await mockFileRepository.saveImage(isOrigin: true, file: data);

        // Then
        expect(result, expectResult);
      });
    });
  });
}
