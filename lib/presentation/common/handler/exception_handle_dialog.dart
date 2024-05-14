import 'package:flutter/material.dart';
import 'package:weaco/core/exception/handler/ExceptionMessageHandler.dart';
import 'package:weaco/presentation/common/component/dialog/one_button_dialog.dart';

class ExceptionHandleDialog {
  final ExceptionMessageHandler _exceptionMessageHandler;

  ExceptionHandleDialog(
      {required ExceptionMessageHandler exceptionMessageHandler})
      : _exceptionMessageHandler = exceptionMessageHandler;

  void showOneButtonDialog(BuildContext context, Exception e) {
    showDialog(
      context: context,
      builder: (context) {
        return OneButtonDialog(
            title: '',
            content: _exceptionMessageHandler.getMessage(e),
            onPressedCheck: () => Navigator.of(context).pop(),
            buttonText: '확인');
      },
    );
  }
}
