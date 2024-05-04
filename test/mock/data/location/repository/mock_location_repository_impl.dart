import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';

class MockLocationRepositoryImpl implements LocationRepository {
  Map<String, dynamic> methodParameterMap = {};
  Location? _localLocation;
  Location? _remoteLocation;

  /// 로컬 DB에 저장된 현재 위치 정보를 요청
  @override
  Future<Location?> getLocalLocation() async {
    return _localLocation;
  }

  /// geolocator 로 현재 위치 정보를 요청
  @override
  Future<Location> getRemoteLocation({
    required Location location
  }) async {
    _remoteLocation = Location(
      lat: location.lat,
      lng: location.lng,
      city: 'city',
      createdAt: location.createdAt,
    );

    return _remoteLocation!;
  }

  void initMockData() {
    methodParameterMap = {};
    _localLocation = null;
    _remoteLocation = null;
  }
}
