import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/use_case/get_edit_location_use_case.dart';

import '../../../mock/data/location/repository/mock_location_repository_impl.dart';

void main() {
  group('GetEditLocationUseCase 클래스', () {
    final locationRepository = MockLocationRepositoryImpl();
    final GetEditLocationUseCase useCase =
        GetEditLocationUseCase(locationRepository: locationRepository);

    setUp(() => locationRepository.initMockData());

    group('getLocalLocation 메서드는', () {
      test('로컬 DB에 저장된 위치 정보를 가져온다.', () async {
        // Given
        Location? expectedResult;

        // When
        await useCase.execute();

        // Then
        expect(await locationRepository.getLocation(), expectedResult);
      });
    });
  });
}
