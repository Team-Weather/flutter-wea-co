import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/common/file/use_case/save_origin_image_use_case.dart';

import '../../../mock/data/common/file/repository/mock_file_repository_impl.dart';

void main() {
  group('SaveOriginImageUseCase 클래스', () {
    final mockFileRepository = MockFileRepositoryImpl();
    final SaveOriginImageUseCase useCase =
        SaveOriginImageUseCase(fileRepository: mockFileRepository);

    setUp(() => mockFileRepository.initMockData());

    group('execute 메서드는', () {
      test('FileRepository.saveData()을 한번 호출한다.', () async {
        // Given
        const expectCount = 1;
        const data = <int>[];

        // When
        await useCase.execute(data: data);

        // Then
        expect(mockFileRepository.saveDataCallCount, expectCount);
      });

      test('인자로 data를 FileRepository.saveData()에 그대로 전달한다.', () async {
        // Given
        const data = <int>[1, 2, 3];

        // When
        await useCase.execute(data: data);

        // Then
        expect(mockFileRepository.methodParameterMap['data'], data);
      });

      test('FileRepository.saveData()을 호출하고 반환 받은 값을 그대로 반환한다.', () async {
        // Given
        const data = <int>[1, 2, 3];
        bool expectResult = false;
        mockFileRepository.fakeSaveDataResult = expectResult;

        // When
        final result = await mockFileRepository.saveData(data: data);

        // Then
        expect(result, expectResult);
      });
    });
  });
}
