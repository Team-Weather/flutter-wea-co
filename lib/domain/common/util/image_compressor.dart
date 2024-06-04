import 'dart:io';

abstract interface class ImageCompressor {
  Future<List<int>> compressImage({required File file});
}
