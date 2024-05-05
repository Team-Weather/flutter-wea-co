import 'package:weaco/domain/common/file/model/profile_image.dart';
import 'package:weaco/domain/common/file/repository/file_repository.dart';

class GetProfileImageListUseCase {
  final FileRepository _fileRepository;

  GetProfileImageListUseCase({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  Future<List<ProfileImage>> execute() async {
    return await _fileRepository.getProfileImageList();
  }
}
