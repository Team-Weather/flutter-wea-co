import 'package:weaco/domain/user/repository/user_profile_repository.dart';
import 'package:weaco/domain/user/model/user_profile.dart';

class GetMyPageUserProfileUseCase {
  final UserProfileRepository _userProfileRepository;

  GetMyPageUserProfileUseCase(
      {required UserProfileRepository userProfileRepository})
      : _userProfileRepository = userProfileRepository;

  /// 레포지토리에 내 프로필을 요청
  /// @return: 내 프로필, 없을 경우 null
  Future<UserProfile?> execute() async {
    return await _userProfileRepository.getMyProfile();
  }
}
