import 'package:weaco/domain/location/model/location.dart';

abstract interface class LocationRepository {
  Future<Location?> getLocation();
}
