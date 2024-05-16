import 'package:flutter/material.dart';
import 'package:weaco/presentation/common/component/dialog/one_button_dialog.dart';
import 'package:weaco/presentation/common/enum/exception_alert.dart';

class AlertUtil {
  static void showAlert({
    required BuildContext context,
    required ExceptionAlert exceptionAlert,
    required String message,
    String? buttonText,
    VoidCallback? onPressedCheck,
  }) {
    switch (exceptionAlert) {
      case ExceptionAlert.snackBar:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
        break;
      case ExceptionAlert.dialog:
        showDialog(
          context: context,
          builder: (context) {
            return OneButtonDialog(
                title: '',
                content: message,
                onPressedCheck: () => onPressedCheck == null
                    ? Navigator.of(context).pop()
                    : onPressedCheck(),
                buttonText: buttonText ?? '확인');
          },
        );
        break;
    }
  }
}
