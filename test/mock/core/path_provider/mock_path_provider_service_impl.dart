import 'package:weaco/core/path_provider/path_provider_service.dart';

class MockPathProviderServiceImpl implements PathProviderService {
  @override
  Future<String> getCacheDirectory() async {
    return 'test/mock/assets';
  }
}
