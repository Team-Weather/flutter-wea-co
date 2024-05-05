import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';

class MockLocationRepositoryImpl implements LocationRepository {
  Map<String, dynamic> methodParameterMap = {};
  int getLocationCallCount = 0;
  Location? getLocationResult;

  void initMockData() {
    getLocationCallCount = 0;
    getLocationResult = null;
    methodParameterMap.clear();
  }

  /// 위도, 경도를 인자로 Location 객체를 반환
  ///
  /// @param [lat] 위도
  /// @param [lng] 경도
  /// @return [Location?] geolocator 로 반환 받은 값을 이용하여 생성한 [Location] 객체
  @override
  Future<Location?> getLocation({
    required double lat,
    required double lng,
  }) async {
    getLocationCallCount++;
    methodParameterMap = {
      'lat': lat,
      'lng': lng,
    };

    return getLocationResult;
  }
}
