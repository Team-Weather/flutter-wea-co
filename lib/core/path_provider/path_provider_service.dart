import 'package:path_provider/path_provider.dart';

class PathProviderService {
  Future<String> getCacheDirectory() async {
    return (await getApplicationCacheDirectory()).path;
  }
}
