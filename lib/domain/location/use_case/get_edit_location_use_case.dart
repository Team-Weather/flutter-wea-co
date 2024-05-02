import 'package:weaco/domain/feed/repository/feed_repository.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';

class GetEditLocationUseCase {
  final LocationRepository _locationRepository;

  GetEditLocationUseCase({
    required LocationRepository locationRepository,
  }) : _locationRepository = locationRepository;

  /// 로컬 DB에 저장된 현재 위치 정보를 요청
  Future<Location?> execute() async {
    return await _locationRepository.getLocalLocation();
  }
}
