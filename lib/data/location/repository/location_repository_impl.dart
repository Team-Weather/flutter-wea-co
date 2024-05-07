import 'package:weaco/core/gps/gps_helper.dart';
import 'package:weaco/core/gps/gps_position.dart';
import 'package:weaco/data/location/data_source/remote_data_source/remote_location_data_source.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final GpsHelper _gpsHelper;
  final RemoteLocationDataSource _remoteDataSource;

  LocationRepositoryImpl(
      {required GpsHelper gpsHelper,
      required RemoteLocationDataSource remoteDataSource})
      : _gpsHelper = gpsHelper,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Location> getLocation() async {
    final GpsPosition position = await _gpsHelper.getPosition();
    final result =
        await _remoteDataSource.getDong(lat: position.lat, lng: position.lng);
    return Location(
        lat: position.lat,
        lng: position.lng,
        city: result,
        createdAt: DateTime.now());
  }
}
