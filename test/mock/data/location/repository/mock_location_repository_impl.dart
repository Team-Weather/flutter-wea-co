import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';

class MockLocationRepositoryImpl implements LocationRepository {
  int getLocationCallCount = 0;
  Location? getLocationResult;

  void initMockData() {
    getLocationCallCount = 0;
    getLocationResult = null;
  }

  /// 위도, 경도를 인자로 Location 객체를 반환
  ///
  /// @return [Location?] geolocator 로 반환 받은 값을 이용하여 생성한 [Location] 객체
  @override
  Future<Location> getLocation() async {
    getLocationCallCount++;

    return getLocationResult ?? (throw Exception('위치 반환 실패'));
  }
}
