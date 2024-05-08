import 'dart:io';

abstract interface class RemoteFileDataSource {
  Future<String> saveImage({required File image, required String email});
}
