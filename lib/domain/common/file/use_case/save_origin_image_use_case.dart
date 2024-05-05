import 'package:weaco/domain/common/file/repository/file_repository.dart';

class SaveOriginImageUseCase {
  final FileRepository _fileRepository;

  SaveOriginImageUseCase({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  /// 레포지토리에 데이터를 전달하여 저장을 요청
  /// @param data: 저장할 데이터
  /// @return: 데이터 저장 성공 여부 반환
  Future<bool> execute({required List<int> data}) async {
    return await _fileRepository.saveData(data: data);
  }
}
