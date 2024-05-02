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
    required double lat,
    required double lng,
    String city = 'city',
  }) async {
    _remoteLocation = Location(
      lat: lat,
      lng: lng,
      city: city,
      createdAt: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        DateTime.now().hour,
        DateTime.now().minute,
      ),
    );

    return _remoteLocation!;
  }

  void initMockData() {
    methodParameterMap = {};
    _localLocation = null;
    _remoteLocation = null;
  }
}
