import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/repository/user_profile_repository.dart';

class GetUserProfileUseCase {
  final UserProfileRepository _userProfileRepository;

  GetUserProfileUseCase({
    required UserProfileRepository userProfileRepository,
  }) : _userProfileRepository = userProfileRepository;

  /// 해당하는 유저 정보를 가져온다.
  /// @return: 해당하는 email 이 없을 경우 null 을 반환
  Future<UserProfile?> execute({required String email}) async {
    return await _userProfileRepository.getUserProfile(email: email);
  }
}
