import 'package:flutter/material.dart';
import 'package:weaco/presentation/common/component/dialog/one_button_dialog.dart';
import 'package:weaco/presentation/common/component/dialog/two_button_dialog.dart';
import 'package:weaco/presentation/common/enum/exception_alert.dart';

class AlertUtil {
  static void showAlert({
    required BuildContext context,
    required ExceptionAlert exceptionAlert,
    required String message,
    String? leftButtonText,
    String? rightButtonText,
    VoidCallback? onPressedLeft,
    VoidCallback? onPressedRight,
  }) {
    switch (exceptionAlert) {
      case ExceptionAlert.snackBar:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
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
                onPressedCheck: () => onPressedRight == null
                    ? Navigator.of(context).pop()
                    : onPressedRight(),
                buttonText: rightButtonText ?? '확인');
          },
        );

        break;

      case ExceptionAlert.twoButtonDialog:
        showDialog(
          context: context,
          builder: (context) {
            return TwoButtonDialog(
              title: '',
              content: message,
              onPressedLeft: () => onPressedLeft == null
                  ? Navigator.of(context).pop()
                  : onPressedLeft(),
              onPressedRight: () => onPressedRight == null
                  ? Navigator.of(context).pop()
                  : onPressedRight(),
              leftButtonText: leftButtonText ?? '확인',
              rightButtonCancelText: rightButtonText ?? '취소',
            );
          },
        );

        break;
    }
  }
}
