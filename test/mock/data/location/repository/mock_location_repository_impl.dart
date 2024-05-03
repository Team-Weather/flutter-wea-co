import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';

class MockLocationRepositoryImpl implements LocationRepository {
  int getLocationCallCount = 0;
  Location? getLocationResult;
  double? lat;
  double? lng;

  void initMockData() {
    getLocationCallCount = 0;
    getLocationResult = null;
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
}
