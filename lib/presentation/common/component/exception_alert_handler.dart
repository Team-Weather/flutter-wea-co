import 'package:flutter/material.dart';
import 'package:weaco/presentation/common/component/dialog/one_button_dialog.dart';
import 'package:weaco/presentation/common/component/dialog/two_button_dialog.dart';
import 'package:weaco/presentation/common/enum/exception_alert_type.dart';

class ExceptionAlertHandler {
  static void showAlert({
    required BuildContext context,
    required ExceptionAlertType exceptionAlert,
    required String message,
    String? dialogTitle,
    String? oneButtonText,
    String? leftButtonText,
    String? rightButtonText,
    VoidCallback? oneButtonCallback,
    VoidCallback? leftButtonCallback,
    VoidCallback? rightButtonCallback,
    bool? barrierDismissible,
  }) {
    switch (exceptionAlert) {
      case ExceptionAlertType.snackBar:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 500),
          behavior: SnackBarBehavior.floating,
          content: Text(message),
        ));
        break;
      case ExceptionAlertType.oneButtonDialog:
        showDialog(
          context: context,
          barrierDismissible: barrierDismissible ?? true,
          builder: (context) {
            return OneButtonDialog(
                title: dialogTitle ?? '알림',
                content: message,
                onPressedCheck: () => oneButtonCallback == null
                    ? Navigator.of(context).pop()
                    : oneButtonCallback(),
                buttonText: oneButtonText ?? '확인');
          },
        );
        break;
      case ExceptionAlertType.twoButtonDialog:
        showDialog(
          context: context,
          barrierDismissible: barrierDismissible ?? false,
          builder: (context) {
            return TwoButtonDialog(
              title: dialogTitle ?? '알림',
              content: message,
              onPressedLeft: () => leftButtonCallback == null
                  ? Navigator.of(context).pop()
                  : leftButtonCallback(),
              onPressedRight: () => rightButtonCallback == null
                ? Navigator.of(context).pop()
                : rightButtonCallback(),
              leftButtonText: leftButtonText ?? '취소',
              rightButtonCancelText: rightButtonText ?? '확인',
            );
          },
        );
        break;
    }
  }
}