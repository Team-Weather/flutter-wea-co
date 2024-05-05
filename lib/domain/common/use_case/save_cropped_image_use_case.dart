import 'package:weaco/domain/common/repository/image_repository.dart';

class SaveCroppedImageUseCase {
  final ImageRepository _imageRepository;

  const SaveCroppedImageUseCase({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;

  /// 이미지를 저장하는 함수
  /// @param data: 이미지 데이터
  /// @return: 이미지 저장 성공 여부
  Future<bool> execute({required List<int> data}) async {
    return await _imageRepository.saveCroppedImage(data: data);
  }
}