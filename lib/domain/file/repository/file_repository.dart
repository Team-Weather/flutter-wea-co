import 'dart:io';

abstract interface class FileRepository {
  Future<File?> getImage({required bool isOrigin});

  Future<bool> saveImage({required bool isOrigin, required File file});

  Future<String> saveOotdImage();
}
