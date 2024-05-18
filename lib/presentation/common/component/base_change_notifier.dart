import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weaco/presentation/common/state/exception_status.dart';

abstract class BaseChangeNotifier extends ChangeNotifier {
  // Stream
  final _exceptionController = StreamController<ExceptionStatus>();
  Stream<ExceptionStatus> get exceptionStateStream => _exceptionController.stream;
  bool get hasStreamListener => _exceptionController.hasListener;

  // Exception -> Stream 전송
  void notifyException({required Object? exception}) {
    log('Exception: ${exception.toString()}',
        name: 'BaseChangeNotifier.notifyException()');
    _exceptionController.add(exceptionToExceptionStatus(exception: exception));
  }

  // Exception -> ExceptionStatus 매핑
  ExceptionStatus exceptionToExceptionStatus({required Object? exception});
}
