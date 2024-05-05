import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';

class MockLocationRepositoryImpl implements LocationRepository {
  Map<String, dynamic> methodParameterMap = {};
  Location? _localLocation;
  Location? _remoteLocation;
  int getLocationCallCount = 0;
  Location? getLocationResult;
  double? lat;
  double? lng;

  void initMockData() {
    getLocationCallCount = 0;
    getLocationResult = null;
    methodParameterMap = {};
    _localLocation = null;
    _remoteLocation = null;
    lat = null;
    lng = null;
  }

  @override
  Future<Location> getLocation(
      {required double lat, required double lng}) async {
    getLocationCallCount++;
    this.lat = lat;
    this.lng = lng;

    return getLocationResult ??
        Location(lat: 0, lng: 0, city: '', createdAt: DateTime.now());
  }

  /// 로컬 DB에 저장된 현재 위치 정보를 요청
  @override
  Future<Location?> getLocation() async {
    return _localLocation;
  }

  /// geolocator 로 현재 위치 정보를 요청
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
}
