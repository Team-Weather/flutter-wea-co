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
      DioExceptionType.connectionTimeout ||
      DioExceptionType.connectionError ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        '네트워크가 불안정 합니다.',
      DioExceptionType.badCertificate => '인증되지 않는 유저입니다.',
      DioExceptionType.badResponse => '잘못된 요청입니다.',
      DioExceptionType.cancel => '요청이 취소되었습니다',
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

  /// Firebase Auth Exception 분기 및 다이얼로그 컨텐츠에 들어갈 메세지 반환
  String _handleAuthException(FirebaseException e) {
    log(e.message ?? 'Auth Error');

    return switch (e.code) {
      'user-not-found' => '존재하지 않는 유저입니다.',
      'wrong-password' => '비밀번호가 맞지 않습니다.',
      'email-already-in-use' => '이미 가입된 이메일입니다.',
      'invalid-email' => '이메일 형식이 올바르지 못합니다.',
      'operation-not-allowed' => '허용되지 않는 요청입니다.',
      'weak-password' => '비밀번호 형식이 안전하지 않습니다.',
      'network-request-failed' => '네트워크가 불안정 합니다.',
      'too-many-requests' => '요청이 너무 많습니다.',
      'user-disabled' => '이미 탈퇴한 회원입니다.',
      _ => 'Auth Error: ${e.message}',
    };
  }

  /// Firebase Firestore Exception 분기 및 다이얼로그 컨텐츠에 들어갈 메세지 반환
  String _handleFirestoreException(FirebaseException e) {
    return switch (e.code) {
      'aborted' => '요청이 중단되었습니다.',
      'already-exists' => '이미 존재하는 데이터입니다.',
      'cancelled' => '요청이 취소되었습니다.',
      'data-loss' => '데이터가 손실되었습니다.',
      'deadline-exceeded' => '기한이 초과된 요청입니다.',
      'failed-precondition' => 'Firestore 오류: 사전 조건 실패',
      'internal' => '서버가 불안정합니다.',
      'invalid-argument' => '잘못된 데이터 인자 입니다.',
      'not-found' => '데이터를 찾을수 없습니다.',
      'out-of-range' => '범위 크기를 초과하였습니다.',
      'permission-denied' => '요청할수 있는 권한이 없습니다.',
      'resource-exhausted' => '더이상 데이터가 없습니다.',
      'unauthenticated' => '인증되지 않는 요청입니다.',
      'unavailable' => '이용이 불가능한 요청입니다.',
      'unimplemented' => '구현되지 않는 요청입니다.',
      'unknown' => '알 수 없는 에러입니다.',
      _ => 'Firestore Error: ${e.message}',
    };
  }

  /// Firebase Storage Exception 분기 및 다이얼로그 컨텐츠에 들어갈 메세지 반환
  String _handleStorageException(FirebaseException e) {
    return switch (e.code) {
      'object-not-found' => '파일 객체를 찾을 수 없습니다.',
      'bucket-not-found' => '버킷을 찾을 수 없습니다.',
      'project-not-found' => '프로젝트를 찾을 수 없습니다.',
      'quota-exceeded' => '할당량이 초과 되었습니다.',
      'unauthenticated' => '인증되지 않은 요청입니다.',
      'unauthorized' => '권한이 없는 요청입니다.',
      'retry-limit-exceeded' => '재시도 한도 초과 되었습니다.',
      'invalid-checksum' => '잘못된 체크섬',
      'canceled' => '요청이 취소 되었습니다.',
      'invalid-event-name' => '이벤트 이름이 잘못 되었습니다.',
      'invalid-url' => '잘못된 URL 입니다.',
      'invalid-argument' => '잘못된 인수 입니다.',
      'no-default-bucket' => '기본 버킷이 없습니다.',
      'cannot-slice-blob' => 'Blob을 자를 수 없습니다.',
      'server-file-wrong-size' => '서버 파일 크기 오류 입니다.',
      _ => 'Storage Error: ${e.message}',
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
}
