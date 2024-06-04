import 'dart:io';
import 'package:image/image.dart' as image;
import 'package:weaco/domain/common/util/image_compressor.dart';

class ImageCompressorImpl implements ImageCompressor {
  int width= 1000;
  int height = 1000 ~/ 9 * 16;

  @override
  Future<List<int>> compressImage({required File file}) async {
    image.Image originImage = (await image.decodeImageFile(file.path))!;
    image.Image resizedImage = image.copyResize(originImage, width: width, height: height);
    List<int> compressedResizedImage = image.encodeJpg(resizedImage, quality: 80);
    return compressedResizedImage;
  }
}