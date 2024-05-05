import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/use_case/get_home_location_use_case.dart';

import '../../../mock/data/location/repository/mock_location_repository_impl.dart';

void main() {
  group('GetHomeLocationUseCase 클래스', () {
    final MockLocationRepositoryImpl mockLocationRepository =
        MockLocationRepositoryImpl();
    final GetHomeLocationUseCase useCase =
        GetHomeLocationUseCase(locationRepository: mockLocationRepository);

    setUp(() => mockLocationRepository.initMockData());

    group('execute 메서드는', () {
      test('LocationRepository.getLocationCallCount()을 한번 호출한다.', () async {
        // Given
        const expectCount = 1;
        const lat = 40.3;
        const lng = 127.3;

        // When
        await useCase.execute(lat: lat, lng: lng);

        // Then
        expect(mockLocationRepository.getLocationCallCount, expectCount);
      });

      test('인자로 받은 lat, lng를 LocationRepository.getLocation()에 그대로 전달한다.',
          () async {
        // Given
        const expectedLat = 40.3;
        const expectedLng = 127.3;

        // When
        await useCase.execute(lat: expectedLat, lng: expectedLng);

        // Then
        expect(mockLocationRepository.lat, expectedLat);
        expect(mockLocationRepository.lng, expectedLng);
      });

      test('LocationRepository.getLocation()를 호출하고 반환 받은 값을 그대로 반환한다.',
          () async {
        // Given
        const lat = 40.3;
        const lng = 127.3;
        final expectLocation = Location(
            lat: lat,
            lng: lng,
            city: 'Seoul',
            createdAt: DateTime.parse('2024-05-01 13:27:00'));
        mockLocationRepository.getLocationResult = expectLocation;

        // When
        final location = await useCase.execute(lat: lat, lng: lng);

        // Then
        expect(location, expectLocation);
      });
    });
  });
}
