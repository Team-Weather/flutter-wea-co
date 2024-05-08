import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:weaco/data/file/data_source/remote/remote_file_data_source.dart';

class RemoteFileDataSourceImpl implements RemoteFileDataSource {
  final FirebaseStorage _firebaseStorage;

  RemoteFileDataSourceImpl({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  @override
  Future<String> saveImage({required File image}) async {
    final splitImagePath = image.path.split('/');
    final imageName = splitImagePath[splitImagePath.length - 1];

    final feedImageRef = _firebaseStorage.ref().child('feed_images/$imageName');
    await feedImageRef.putFile(image);

    return await feedImageRef.getDownloadURL();
  }
}
