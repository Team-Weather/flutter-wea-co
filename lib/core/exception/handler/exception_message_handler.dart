import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weaco/core/exception/custom_business_exception.dart';
import 'package:weaco/core/exception/internal_server_exception.dart';
import 'package:weaco/core/exception/not_found_exception.dart';

class ExceptionMessageHandler {
  String getMessage(Exception e) {
    return switch (e) {
      DioException _ => _dioExceptionHandle(e),
      FirebaseException _ => _firebaseExceptionHandle(e),
      CustomBusinessException _ => _businessExceptionHandle(e),
      _ => '알 수 없는 오류',
    };
  }

  /// Dio Exception 분기 및 다이얼로그 컨텐츠에 들어갈 메세지 반환
  String _dioExceptionHandle(DioException e) {
    log(e.message ?? 'Dio Error');

    return switch (e.type) {
      DioExceptionType.connectionTimeout => '연결 시간 초과',
      DioExceptionType.sendTimeout => '전송 시간 초과',
      DioExceptionType.receiveTimeout => '수신 시간 초과',
      DioExceptionType.badCertificate => '잘못된 인증서',
      DioExceptionType.badResponse => '잘못된 응답',
      DioExceptionType.cancel => '요청이 취소되었습니다',
      DioExceptionType.connectionError => 'connection error',
      DioExceptionType.unknown => '알 수 없는 오류',
    };
  }

  /// Firebase Auth, Firestore, Storage 분기
  String _firebaseExceptionHandle(FirebaseException e) {
    return switch (e.plugin) {
      'firebase_auth' => _handleAuthException(e),
      'firebase_firestore' => _handleFirestoreException(e),
      'firebase_storage' => _handleStorageException(e),
      _ => '알수없는 에러가 발생하였습니다.(파이어베이스)',
    };
  }

  /// 비즈니스 로직에서 발생하는 예외 분기 및 다이얼로그 컨텐츠에 들어갈 메세지 반환
  String _businessExceptionHandle(CustomBusinessException e) {
    log(e.message);

    return switch (e) {
      InternalServerException _ => e.message,
      NotFoundException _ => e.message,
      _ => '알수없는 에러가 발생하였습니다.${e.message}',
    };
  }

  /// Firebase Auth Exception 분기 및 다이얼로그 컨텐츠에 들어갈 메세지 반환
  String _handleAuthException(FirebaseException e) {
    log(e.message ?? 'Auth Error');

    return switch (e.code) {
      'user-not-found' => 'Auth Error: User not found',
      'wrong-password' => 'Auth Error: Wrong password',
      'email-already-in-use' => 'Auth Error: Email already in use',
      'invalid-email' => 'Auth Error: Invalid email',
      'operation-not-allowed' => 'Auth Error: Operation not allowed',
      'weak-password' => 'Auth Error: Weak password',
      'network-request-failed' => 'Auth Error: Network request failed',
      'too-many-requests' => 'Auth Error: Too many requests',
      'user-disabled' => 'Auth Error: User account disabled',
      _ => 'Auth Error: ${e.message}',
    };
  }

  /// Firebase Firestore Exception 분기 및 다이얼로그 컨텐츠에 들어갈 메세지 반환
  String _handleFirestoreException(FirebaseException e) {
    return switch (e.code) {
      'aborted' => 'Firestore Error: Aborted',
      'already-exists' => 'Firestore Error: Already exists',
      'cancelled' => 'Firestore Error: Cancelled',
      'data-loss' => 'Firestore Error: Data loss',
      'deadline-exceeded' => 'Firestore Error: Deadline exceeded',
      'failed-precondition' => 'Firestore Error: Failed precondition',
      'internal' => 'Firestore Error: Internal',
      'invalid-argument' => 'Firestore Error: Invalid argument',
      'not-found' => 'Firestore Error: Not found',
      'out-of-range' => 'Firestore Error: Out of range',
      'permission-denied' => 'Firestore Error: Permission denied',
      'resource-exhausted' => 'Firestore Error: Resource exhausted',
      'unauthenticated' => 'Firestore Error: Unauthenticated',
      'unavailable' => 'Firestore Error: Unavailable',
      'unimplemented' => 'Firestore Error: Unimplemented',
      'unknown' => 'Firestore Error: Unknown',
      _ => 'Firestore Error: ${e.message}',
    };
  }

  /// Firebase Storage Exception 분기 및 다이얼로그 컨텐츠에 들어갈 메세지 반환
  String _handleStorageException(FirebaseException e) {
    return switch (e.code) {
      'object-not-found' => 'Storage Error: Object not found',
      'bucket-not-found' => 'Storage Error: Bucket not found',
      'project-not-found' => 'Storage Error: Project not found',
      'quota-exceeded' => 'Storage Error: Quota exceeded',
      'unauthenticated' => 'Storage Error: Unauthenticated',
      'unauthorized' => 'Storage Error: Unauthorized',
      'retry-limit-exceeded' => 'Storage Error: Retry limit exceeded',
      'invalid-checksum' => 'Storage Error: Invalid checksum',
      'canceled' => 'Storage Error: Canceled',
      'invalid-event-name' => 'Storage Error: Invalid event name',
      'invalid-url' => 'Storage Error: Invalid URL',
      'invalid-argument' => 'Storage Error: Invalid argument',
      'no-default-bucket' => 'Storage Error: No default bucket',
      'cannot-slice-blob' => 'Storage Error: Cannot slice blob',
      'server-file-wrong-size' => 'Storage Error: Server file wrong size',
      _ => 'Storage Error: ${e.message}',
    };
  }
}
