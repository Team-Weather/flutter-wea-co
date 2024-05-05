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
        final Map<String, double> expectParameter = {
          'lat': 40.3,
          'lng': 127.3,
        };

        // When
        await getLocationFromCoordinateUseCase.execute(
          lat: expectParameter['lat']!,
          lng: expectParameter['lng']!,
        );

        // Then
        expect(mockLocationRepositoryImpl.getLocationCallCount, expectCount);
      });

      test('인자로 받은 lat, lng를 LocationRepository.getLocation()에 그대로 전달한다.',
          () async {
        // When
        final Map<String, double> expectParameter = {
          'lat': 40.3,
          'lng': 127.3,
        };
        await getLocationFromCoordinateUseCase.execute(
          lat: expectParameter['lat']!,
          lng: expectParameter['lng']!,
        );

        // Then
        expect(mockLocationRepositoryImpl.methodParameterMap, expectParameter);
      });

      test('LocationRepository.getLocation()를 호출하고 반환 받은 값을 그대로 반환한다.',
          () async {
        // Given
        final Map<String, double> expectParameter = {
          'lat': 40.3,
          'lng': 127.3,
        };
        final expectLocation = Location(
          lat: expectParameter['lat']!,
          lng: expectParameter['lng']!,
          city: 'Seoul',
          createdAt: DateTime.parse('2024-05-01 13:27:00'),
        );

        mockLocationRepositoryImpl.getLocationResult = expectLocation;

        // When
        final actualLocation = await getLocationFromCoordinateUseCase.execute(
          lat: expectParameter['lat']!,
          lng: expectParameter['lng']!,
        );

        // Then
        expect(actualLocation, expectLocation);
      });
    });
  });
}
