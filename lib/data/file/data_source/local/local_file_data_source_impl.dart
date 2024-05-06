import 'dart:developer';
import 'dart:io';
import 'package:weaco/core/path_provider/path_provider_service.dart';
import 'local_file_data_source.dart';

class LocalFileDataSourceImpl implements LocalFileDataSource {
  final _originImageFileName = 'origin.png';
  final _croppedImageFileName = 'cropped.png';
  final PathProviderService _pathProvider;

  LocalFileDataSourceImpl({required PathProviderService pathProvider})
      : _pathProvider = pathProvider;

  @override
  Future<File?> getImagePath({required bool isOrigin}) async {
    try {
      final directory = await _pathProvider.getCacheDirectory();
      String fileName = isOrigin ? _originImageFileName : _croppedImageFileName;
      return (await File('$directory/$fileName').exists())
          ? File('$directory/$fileName')
          : null;
    } catch (e) {
      log(e.toString(), name: 'LocalFileDataSourceImpl.getImagePath()');
      return null;
    }
  }

  @override
  Future<bool> saveImage({required bool isOrigin, required File file}) async {
    try {
      final directory = await _pathProvider.getCacheDirectory();
      String fileName = isOrigin ? _originImageFileName : _croppedImageFileName;
      if (await File('$directory/$fileName').exists()) {
        await File('$directory/$fileName').delete();
      }
      await File('$directory/$fileName').writeAsBytes(await file.readAsBytes());
      return true;
    } catch (e) {
      log(e.toString(), name: 'LocalFileDataSourceImpl.saveImage()');
      return false;
    }
  }
}
