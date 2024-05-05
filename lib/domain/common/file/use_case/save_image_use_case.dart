import 'dart:io';

import 'package:weaco/domain/common/file/repository/file_repository.dart';

class SaveImageUseCase {
  final FileRepository _fileRepository;

  SaveImageUseCase({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  /// 레포지토리에 이미지 파일 데이터를 전달하여 저장을 요청
  /// @param isOrigin: 원본 이미지 = true, 크롭된 이미지 = false
  /// @param file: 저장할 이미지 데이터
  /// @return: 데이터 저장 성공 여부 반환
  Future<bool> execute({required bool isOrigin, required File file}) async {
    return await _fileRepository.saveImage(isOrigin: isOrigin, file: file);
  }
}
