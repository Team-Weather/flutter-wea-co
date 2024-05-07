import 'dart:io';

abstract interface class RemoteFileDataSource {
  Future<String?> saveImage(File image);
}
