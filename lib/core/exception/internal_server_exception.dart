import 'package:weaco/core/exception/custom_business_exception.dart';

/// 서버 내부 오류 예외
class InternalServerException extends CustomBusinessException {
  InternalServerException({required super.code, required super.message});
}
