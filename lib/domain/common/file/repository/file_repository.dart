import 'dart:io';

abstract interface class FileRepository {
  Future<bool> saveData({required List<int> data});

  Future<File?> getCroppedImage({required List<int> data});
}