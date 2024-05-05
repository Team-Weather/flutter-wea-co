import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/use_case/get_location_from_coordinate_use_case.dart';

import '../../../mock/data/location/repository/mock_location_repository_impl.dart';

void main() {
  group('GetLocationFromCoordinateUseCase 클래스', () {
    final MockLocationRepositoryImpl mockLocationRepositoryImpl =
        MockLocationRepositoryImpl();

    final GetLocationFromCoordinateUseCase getLocationFromCoordinateUseCase =
        GetLocationFromCoordinateUseCase(
            locationRepository: mockLocationRepositoryImpl);

    setUp(() => mockLocationRepositoryImpl.initMockData());

    group('execute 메서드는', () {
      test('LocationRepository.getLocation()을 한번 호출한다.', () async {
        // Given
        const expectCount = 1;
        // When
        await getLocationFromCoordinateUseCase.execute();

        // Then
        expect(mockLocationRepositoryImpl.getLocationCallCount, expectCount);
      });

      test('LocationRepository.getLocation()를 호출하고 반환 받은 값을 그대로 반환한다.',
          () async {
        // Given
        final expectLocation = Location(
          lat: 40.3,
          lng: 127.3,
          city: 'Seoul',
          createdAt: DateTime.parse('2024-05-01 13:27:00'),
        );

        mockLocationRepositoryImpl.getLocationResult = expectLocation;

        // When
        final actualLocation = await getLocationFromCoordinateUseCase.execute();

        // Then
        expect(actualLocation, expectLocation);
      });
    });
  });
}
