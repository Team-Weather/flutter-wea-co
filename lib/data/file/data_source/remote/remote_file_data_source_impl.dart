import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:weaco/data/file/data_source/remote/remote_file_data_source.dart';

class RemoteFileDataSourceImpl implements RemoteFileDataSource {
  final FirebaseStorage _firebaseStorage;

  RemoteFileDataSourceImpl() : _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<String?> saveImage(File image) async {
    try {
      final feedImageRef = _firebaseStorage.ref().child("feed_images");
      await feedImageRef.putFile(image);

      return await feedImageRef.getDownloadURL();
    } on Exception catch (e) {
      log(e.toString(), name: 'RemoteFileDataSourceImpl.saveImage()');
      return null;
    }
  }
}
