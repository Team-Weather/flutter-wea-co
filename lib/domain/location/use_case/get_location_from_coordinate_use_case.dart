import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';

class GetLocationFromCoordinateUseCase {
  final LocationRepository _locationRepository;

  GetLocationFromCoordinateUseCase({
    required LocationRepository locationRepository,
  }) : _locationRepository = locationRepository;

  /// 위도, 경도로 위치 정보를 가져오기 위한 Use Case
  /// @param [lat] 위도
  /// @param [lng] 경도
  /// @return [Location] 위치 정보
  Future<Location?> execute({
    required double lat,
    required double lng,
  }) async {
    return await _locationRepository.getLocation(lat: lat, lng: lng);
  }
}
