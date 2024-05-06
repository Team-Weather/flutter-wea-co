import 'package:weaco/core/exception/custom_business_exception.dart';

class NotFoundException extends CustomBusinessException {
  NotFoundException({required super.code, required super.message});
}
