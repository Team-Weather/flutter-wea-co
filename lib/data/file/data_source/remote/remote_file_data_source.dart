import 'dart:io';

abstract interface class RemoteFileDataSource {
  Future<List<String>> saveImage({required File croppedImage, required File compressedImage});
}
