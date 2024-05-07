import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/core/gps/gps_position.dart';
import 'package:weaco/data/location/repository/location_repository_impl.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';

import '../../../mock/core/gps/mock_gps_helper_impl.dart';
import '../../../mock/data/location/data_source/mock_remote_location_data_source_impl.dart';

void main() {
  group('LocationRepositoryImpl 클래스', () {
    final mockGpsHelper = MockGpsHelperImpl();
    final mockDataSource = MockRemoteLocationDataSourceImpl();
    final LocationRepository repository = LocationRepositoryImpl(
        gpsHelper: mockGpsHelper, remoteDataSource: mockDataSource);

    group('getLocation 메서드는', () {
      tearDown(() {
        mockDataSource.initMockData();
        mockGpsHelper.initMockData();
      });

      test('GpsHelper.getPosition 메서드를 한번 호출한다.', () async {
        // Given
        final GpsPosition position = GpsPosition(lat: 37.123, lng: 128.123);
        mockGpsHelper.methodResult = position;
        mockDataSource.methodResult = '';

        // When
        await repository.getLocation();

        // Then
        expect(mockGpsHelper.methodCallCount, 1);
      });

      test(
          'GpsHelper.getPosition()을 통해 반환 받은 GpsPosition의 lat, lng 값을 통해 RemoteLocationDataSource.getDong()을 한번 호출한다.',
          () async {
        // Given
        final GpsPosition position = GpsPosition(lat: 37.123, lng: 128.123);
        mockGpsHelper.methodResult = position;
        mockDataSource.methodResult = '';

        // When
        await repository.getLocation();

        // Then
        expect(mockDataSource.methodParameter['lng'], position.lng);
        expect(mockDataSource.methodParameter['lat'], position.lat);
        expect(mockDataSource.methodCallCount, 1);
      });

      test('RemoteLocationDataSource.getDong()을 호출하여 GpsPosition을 한국 주소로 변환한다.',
          () async {
        // Given
        final GpsPosition position = GpsPosition(lat: 37.123, lng: 128.123);
        mockGpsHelper.methodResult = position;
        const address = '서울시 노원구';
        mockDataSource.methodResult = address;

        // When
        final result = await repository.getLocation();

        // Then
        expect(result.city, address);
      });

      test(
          'GpsHelper.getPosition()을 통해 반환 받은 GpsPosition의 lat, lng 값과 RemoteLocationDataSource.getDong()을 통해 반환 받은 주소를 조합하여 Location을 반환한다.',
          () async {
        // Given
        final GpsPosition position = GpsPosition(lat: 37.123, lng: 128.123);
        mockGpsHelper.methodResult = position;
        mockGpsHelper.methodResult = position;
        const address = '서울시 노원구';
        mockDataSource.methodResult = address;
        final createdAt = DateTime.now();
        final Location expectLocation = Location(
            lat: position.lat,
            lng: position.lng,
            city: address,
            createdAt: createdAt);

        // When
        final result = await repository.getLocation();

        // Then
        expect(result.lat, expectLocation.lat);
        expect(result.lng, expectLocation.lng);
        expect(result.city, expectLocation.city);
      });
    });
  });
}
