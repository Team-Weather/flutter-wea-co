import 'dart:io';

import 'package:weaco/domain/file/repository/file_repository.dart';

class GetImageUseCase {
  final FileRepository _fileRepository;

  GetImageUseCase({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  /// 레포지토리에 크롭 전 이미지를 요청
  /// @param isOrigin: 원본 이미지 = true, 크롭된 이미지 = false
  /// @return: 요청한 이미지 파일 반환
  Future<File?> execute({required bool isOrigin}) async {
    return await _fileRepository.getImage(isOrigin: isOrigin);
  }
}
