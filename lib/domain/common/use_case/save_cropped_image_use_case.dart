import 'package:weaco/domain/common/repository/image_repository.dart';
import 'package:weaco/domain/feed/model/feed.dart';

class SaveCroppedImageUseCase {
  final ImageRepository _imageRepository;

  SaveCroppedImageUseCase(this._imageRepository);

  /// 레포지토리에 이미지 imagePath를 전달하여 해당 이미지를 저장한다.
  /// @param imagePath: 이미지 경로
  /// @return Feed: 피드
  Future<Feed> execute(String imagePath) async {
    return _imageRepository.saveCroppedImage(imagePath);
  }
}