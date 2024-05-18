import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/presentation/common/component/base_change_notifier.dart';
import 'package:weaco/presentation/common/component/exception_alert_handler.dart';
import 'package:weaco/presentation/common/state/base_alert_data.dart';
import 'package:weaco/presentation/common/state/exception_status.dart';

abstract class BaseState<S extends StatefulWidget, V extends BaseChangeNotifier> extends State<S> {
  // Stream 구독 정보 (dispose 대비)
  StreamSubscription<ExceptionStatus>? exceptionStreamSubscription;

  // 알림창에 표시할 정보
  BaseAlertData get baseAlertData;
  set baseAlertData(BaseAlertData data);

  @override
  void dispose() {
    super.dispose();
    exceptionStreamSubscription?.cancel();
  }

  @override
  void initState() {
    super.initState();
    if (context.read<V>().hasStreamListener) return;
    context.read<V>().exceptionStateStream.listen((exceptionState) {
      log('exceptionStateStream.listen() 콜백 실행',
          name: 'BaseStateWidget.initState');
      Future.microtask(() {
        ExceptionAlertHandler.showAlert(
          exceptionAlert: exceptionState.exceptionAlertType,
          context: context,
          dialogTitle: baseAlertData.dialogTitle,
          message: exceptionState.message,
          barrierDismissible: baseAlertData.barrierDismissible,
          oneButtonText: baseAlertData.oneButtonText,
          leftButtonText: baseAlertData.leftButtonText,
          rightButtonText: baseAlertData.rightButtonText,
          oneButtonCallback: baseAlertData.oneButtonCallback,
          leftButtonCallback: baseAlertData.leftButtonCallback,
          rightButtonCallback: baseAlertData.rightButtonCallback,
        );
      });
    });
  }
}

