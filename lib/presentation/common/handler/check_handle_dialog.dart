import 'package:flutter/material.dart';
import 'package:weaco/presentation/common/component/dialog/one_button_dialog.dart';

class CheckHandleDialog {
  void showOneButtonDialog({
    required BuildContext context,
    required String content,
    required String buttonText,
    required VoidCallback onPressedCheck,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return OneButtonDialog(
            title: '',
            content: content,
            onPressedCheck: () => onPressedCheck(),
            buttonText: buttonText);
      },
    );
  }
}
