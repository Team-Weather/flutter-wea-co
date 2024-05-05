import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';

class MockLocationRepositoryImpl implements LocationRepository {
  Map<String, dynamic> methodParameterMap = {};
  int getLocationCallCount = 0;
  Location? getLocationResult;
  double? lat;
  double? lng;

  void initMockData() {
    getLocationCallCount = 0;
    getLocationResult = null;
    methodParameterMap = {};
    lat = null;
    lng = null;
  }

  /// 파라미터가 널러블일 경우 로컬 DB에 저장된 현재 위치 정보를 요청
  /// 파라미터가 널러블이 아닐 경우 geolocator 로 현재 위치 정보를 요청
  @override
  Future<Location?> getLocation({double? lat, double? lng}) async {
    getLocationCallCount++;
    this.lat = lat;
    this.lng = lng;

    return getLocationResult;
  }
}
