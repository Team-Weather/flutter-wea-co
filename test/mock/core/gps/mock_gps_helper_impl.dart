import 'package:weaco/core/gps/gps_helper.dart';
import 'package:weaco/core/gps/gps_permission_status.dart';
import 'package:weaco/core/gps/gps_position.dart';

class MockGpsHelperImpl implements GpsHelper {
  int methodCallCount = 0;
  dynamic methodResult;
  final Map<String, dynamic> methodParameter = {};

  void initMockData() {
    methodCallCount = 0;
    methodResult = null;
    methodParameter.clear();
  }

  @override
  Future<GpsPermissionStatus> getPermission() async {
    methodCallCount++;
    return methodResult;
  }

  @override
  Future<GpsPosition> getPosition() async {
    methodCallCount++;
    return methodResult;
  }
}
