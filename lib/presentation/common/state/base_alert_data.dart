import 'package:flutter/material.dart';

class BaseAlertData {
  final String? dialogTitle; // 짜피 안보여짐
  final String? oneButtonText;
  final String? leftButtonText;
  final String? rightButtonText;
  final VoidCallback? oneButtonCallback;
  final VoidCallback? leftButtonCallback;
  final VoidCallback? rightButtonCallback;
  final bool? barrierDismissible;

  BaseAlertData(
      {this.dialogTitle,
        this.oneButtonText,
        this.leftButtonText,
        this.rightButtonText,
        this.oneButtonCallback,
        this.leftButtonCallback,
        this.rightButtonCallback,
        this.barrierDismissible});
}