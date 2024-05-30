import 'package:flutter/material.dart';
import 'package:weaco/presentation/common/component/dialog/one_button_dialog.dart';
import 'package:weaco/presentation/common/component/dialog/two_button_dialog.dart';
import 'package:weaco/presentation/common/enum/exception_alert.dart';

class AlertUtil {
  static void showAlert({
    required BuildContext context,
    required ExceptionAlert exceptionAlert,
    required String message,
    String? buttonText,
    String? leftButtonText,
    String? rightButtonText,
    VoidCallback? onPressedCheck,
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
                onPressedCheck: () => onPressedCheck == null
                    ? Navigator.of(context).pop()
                    : onPressedCheck(),
                buttonText: buttonText ?? '확인');
          },
        );

        break;
      case ExceptionAlert.dialogTwoButton:
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
              leftButtonColor: const Color(0xffB2B2B2).value,
              leftButtonText: leftButtonText ?? '취소',
              rightButtonColor: Theme.of(context).primaryColor.value,
              rightButtonCancelText: rightButtonText ?? '확인',
            );
          },
        );
        break;
    }
  }
}
