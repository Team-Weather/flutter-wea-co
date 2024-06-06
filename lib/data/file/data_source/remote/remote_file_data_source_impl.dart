import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:weaco/core/enum/exception_code.dart';
import 'package:weaco/core/exception/authentication_exception.dart';
import 'package:weaco/core/exception/internal_server_exception.dart';
import 'package:weaco/core/exception/network_exception.dart';
import 'package:weaco/core/firebase/firebase_auth_service.dart';
import 'package:weaco/data/file/data_source/remote/remote_file_data_source.dart';

class RemoteFileDataSourceImpl implements RemoteFileDataSource {
  final FirebaseStorage _firebaseStorage;
  final FirebaseAuthService _firebaseAuthService;

  RemoteFileDataSourceImpl(
      {required FirebaseStorage firebaseStorage,
      required FirebaseAuthService firebaseAuthService})
      : _firebaseStorage = firebaseStorage,
        _firebaseAuthService = firebaseAuthService;

  @override
  Future<List<String>> saveImage(
      {required File croppedImage, required File compressedImage}) async {
    try {
      final String? email =
          _firebaseAuthService.firebaseAuth.currentUser?.email;
      if (email == null) {
        throw AuthenticationException(
            code: ExceptionCode.authenticationNotExistException,
            message: 'FirebaseAuth 로그인 정보 없음');
      }
      final feedOriginImageRef = _firebaseStorage.ref().child(
          'feed_origin_images/${email}_${DateTime.now().microsecondsSinceEpoch}.png');
      await feedOriginImageRef.putFile(croppedImage);
      final feedThumbnailImageRef = _firebaseStorage.ref().child(
          'feed_thumbnail_images/${email}_${DateTime.now().microsecondsSinceEpoch}.png');
      await feedThumbnailImageRef.putFile(compressedImage);
      return [
        await feedOriginImageRef.getDownloadURL(),
        await feedThumbnailImageRef.getDownloadURL()
      ];
    } catch (e) {
      throw switch (e) {
        FirebaseException _ => InternalServerException(
            code: ExceptionCode.internalServerException,
            message: 'Firebase Storage 저장 실패'),
        DioException _ => NetworkException(
            code: ExceptionCode.networkException, message: '네트워크 요청 오류: $e'),
        _ => e,
      };
    }
  }
}
