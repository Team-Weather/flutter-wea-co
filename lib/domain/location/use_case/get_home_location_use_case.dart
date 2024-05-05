import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';

class GetHomeLocationUseCase {
  final LocationRepository _locationRepository;

  GetHomeLocationUseCase({
    required LocationRepository locationRepository,
  }) : _locationRepository = locationRepository;

  /// 홈 화면의 위치 정보를 가져오기 위한 Use Case
  /// [lat] 위도
  /// [lng] 경도
  /// return [Location] 위치 정보
  Future<Location?> execute({required double lat, required double lng}) async {
    return await _locationRepository.getLocation(lat: lat, lng: lng);
  }
}
