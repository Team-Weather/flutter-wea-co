import 'dart:io';

import 'package:weaco/domain/common/util/image_compressor.dart';

class MockImageCompressorImpl implements ImageCompressor {
  @override
  Future<List<int>> compressImage({required File file}) async {
    return [];
  }

}