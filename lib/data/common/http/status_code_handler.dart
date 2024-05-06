import 'package:weaco/core/exception/custom_business_exception.dart';
import 'package:weaco/core/exception/internal_server_exception.dart';

import '../../../core/exception/not_found_exception.dart';

/// 상태코드 이용하여 특정 Exception 받환하는 핸들러
CustomBusinessException statusCodeHandler({int? code, String? message}) {
  return switch (code) {
    404 => NotFoundException(
        code: code!, message: message ?? 'Data Not Found Error'),
    _ => InternalServerException(
        code: code ?? 500, message: message ?? 'Internal Server Error'),
  };
}
