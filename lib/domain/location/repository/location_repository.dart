import 'package:weaco/domain/location/model/location.dart';

abstract interface class LocationRepository {
  Future<Location> getLocation({int? lat, int? lng});

  Future<void> saveLocation({Location location});
}
