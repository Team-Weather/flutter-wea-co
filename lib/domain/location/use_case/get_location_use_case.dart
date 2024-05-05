import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';

class GetLocationUseCase {
  final LocationRepository _locationRepository;

  GetLocationUseCase({
    required LocationRepository locationRepository,
  }) : _locationRepository = locationRepository;

  /// 위도, 경도로 위치 정보를 가져오기 위한 Use Case
  /// @return [Location] 위치 정보
  Future<Location?> execute() async {
    return await _locationRepository.getLocation();
  }
}
