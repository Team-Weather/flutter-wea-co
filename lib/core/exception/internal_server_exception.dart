import 'package:weaco/core/exception/custom_business_exception.dart';

class InternalServerException extends CustomBusinessException {
  InternalServerException({required super.code, required super.message});
}
