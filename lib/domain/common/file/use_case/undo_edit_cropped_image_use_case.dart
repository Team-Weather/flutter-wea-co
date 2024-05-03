import 'package:weaco/domain/common/file/repository/file_repository.dart';

class UndoEditCroppedImageUseCase {
  final FileRepository _fileRepository;

  UndoEditCroppedImageUseCase({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  /// 레포지토리에 저장된 크롭 이미지에 대한 삭제 요청
  /// @return: 삭제 성공 여부 반환
  Future<bool> execute() async {
    return await _fileRepository.removeCroppedImage();
  }
}
