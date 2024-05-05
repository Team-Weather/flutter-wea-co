import 'dart:io';
import 'package:weaco/domain/common/file/repository/file_repository.dart';

class GetOriginImageUseCase {
  final FileRepository _fileRepository;

  GetOriginImageUseCase({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  /// 레포지토리에 크롭 전 이미지를 요청
  /// @return: 크롭 전 이미지, 없을 경우 null
  Future<File?> execute() async {
    return await _fileRepository.getOriginImage();
  }
}
