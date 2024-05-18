import 'package:weaco/presentation/common/enum/exception_alert_type.dart';

class ExceptionStatus {
  final String message;
  final ExceptionAlertType exceptionAlertType;

  ExceptionStatus({
    required this.message,
    required this.exceptionAlertType,
  });
}
