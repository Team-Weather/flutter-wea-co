import 'dart:io';
import 'package:weaco/data/file/data_source/local/local_file_data_source.dart';
import 'package:weaco/data/file/data_source/remote/remote_file_data_source.dart';
import 'package:weaco/domain/file/repository/file_repository.dart';

class FileRepositoryImpl implements FileRepository {
  final LocalFileDataSource _localFileDataSource;
  final RemoteFileDataSource _remoteFileDataSource;

  FileRepositoryImpl(
      {required LocalFileDataSource localFileDataSource,
      required RemoteFileDataSource remoteFileDataSource})
      : _localFileDataSource = localFileDataSource,
        _remoteFileDataSource = remoteFileDataSource;

  @override
  Future<File?> getImage({required bool isOrigin}) async {
    return await _localFileDataSource.getImage(isOrigin: isOrigin);
  }

  @override
  Future<bool> saveImage({required bool isOrigin, required File file}) async {
    return await _localFileDataSource.saveImage(isOrigin: isOrigin, file: file);
  }

  @override
  Future<String> saveOotdImage() async {
    final File? image = await _localFileDataSource.getImage(isOrigin: false);
    if (image == null) throw Exception();
    return await _remoteFileDataSource.saveImage(image: image);
  }
}
