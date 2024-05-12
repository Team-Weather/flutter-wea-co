import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:weaco/core/firebase/firebase_auth_service.dart';
import 'package:weaco/data/file/data_source/remote/remote_file_data_source.dart';

class RemoteFileDataSourceImpl implements RemoteFileDataSource {
  final FirebaseStorage _firebaseStorage;
  final FirebaseAuthService _firebaseAuthService;

  RemoteFileDataSourceImpl(
      {required FirebaseStorage firebaseStorage, required FirebaseAuthService firebaseAuthService})
      : _firebaseStorage = firebaseStorage,
        _firebaseAuthService = firebaseAuthService;

  @override
  Future<String> saveImage({required File image}) async {
    final String? email = _firebaseAuthService.firebaseAuth.currentUser?.email;
    if (email == null) throw Exception();
    final feedImageRef = _firebaseStorage.ref().child(
        'feed_images/${email}_${DateTime
            .now()
            .microsecondsSinceEpoch}.png');
    await feedImageRef.putFile(image);

    return await feedImageRef.getDownloadURL();
  }
}
