import 'package:weaco/core/exception/custom_business_exception.dart';

/// 리소스(ex) EndPoint, data)를 찾을 수 없는 예외
class NotFoundException extends CustomBusinessException {
  NotFoundException({required super.code, required super.message});
}
