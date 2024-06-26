import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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
    final String? email = _firebaseAuthService.firebaseAuth.currentUser?.email;
    if (email == null) throw Exception();
    final feedOriginImageRef = _firebaseStorage.ref().child(
        'feed_origin_images/${email}_${DateTime.now().microsecondsSinceEpoch}.png');
    final feedThumbnailImageRef = _firebaseStorage.ref().child(
        'feed_thumbnail_images/${email}_${DateTime.now().microsecondsSinceEpoch}.png');

    await Future.wait([
      feedOriginImageRef.putFile(croppedImage),
      feedThumbnailImageRef.putFile(compressedImage),
    ]);

    return await Future.wait([
      feedOriginImageRef.getDownloadURL(),
      feedThumbnailImageRef.getDownloadURL()
    ]);
  }
}
