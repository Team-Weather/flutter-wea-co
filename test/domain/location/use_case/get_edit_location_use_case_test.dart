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
        expect(await locationRepository.getLocalLocation(), expectedResult);
      });

      test('로컬 DB에 저장된 값이 없을 경우, geolocator 로 현재 위치 정보를 얻어온다.', () async {
        // Given
        const double lat = 37.58;
        const double lng = 126.97;
        final expectedResult = Location(
          lat: lat,
          lng: lng,
          city: 'city',
          createdAt: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute,
          ),
        );

        await useCase.execute();

        // When
        final actual =
            await locationRepository.getRemoteLocation(lat: lat, lng: lng);

        // Then
        expect(actual, expectedResult);
      });
    });
  });
}
