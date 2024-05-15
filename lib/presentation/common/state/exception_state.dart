import 'package:weaco/presentation/common/enum/exception_alert.dart';

class ExceptionState {
  final String message;
  final ExceptionAlert exceptionAlert;

  ExceptionState({
    required this.message,
    required this.exceptionAlert,
  });
}
