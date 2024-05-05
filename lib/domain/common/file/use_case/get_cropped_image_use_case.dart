import 'dart:io';
import 'package:weaco/domain/common/file/repository/file_repository.dart';

class GetCroppedImageUseCase {
  final FileRepository _fileRepository;

  GetCroppedImageUseCase({required FileRepository fileRepository,})
      : _fileRepository = fileRepository;

  /// 레포지토리에 저장된 크롭 후 이미지를 요청
  /// @param data: 저장된 이미지 데이터
  /// @return: 크롭 후 이미지 파일, 없을 경우 null 반환
  Future<File?> execute() async {
    return await _fileRepository.getCroppedImage();
  }
}