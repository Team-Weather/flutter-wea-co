import 'package:weaco/data/location/data_source/remote_data_source/remote_location_data_source.dart';

class MockRemoteLocationDataSourceImpl implements RemoteLocationDataSource {
  int methodCallCount = 0;
  dynamic methodResult;
  final Map<String, dynamic> methodParameter = {};

  void initMockData() {
    methodCallCount = 0;
    methodResult = null;
    methodParameter.clear();
  }

  @override
  Future<String> getDong({required double lat, required double lng}) async {
    methodCallCount++;
    methodParameter['lat'] = lat;
    methodParameter['lng'] = lng;
    return methodResult;
  }
}
