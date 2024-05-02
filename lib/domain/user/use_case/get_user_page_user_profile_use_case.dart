import 'package:weaco/domain/user/repository/user_profile_repository.dart';
import 'package:weaco/domain/user/model/user_profile.dart';

class GetUserPageUserProfileUseCase {
  final UserProfileRepository _userProfileRepository;

  GetUserPageUserProfileUseCase(
      {required UserProfileRepository userProfileRepository})
      : _userProfileRepository = userProfileRepository;

  /// 레포지토리에 이메일을 통해 유저 프로필을 요청
  /// @param userEmail: 유저의 이메일
  /// @return: userEmail과 동일한 이메일을 가진 유저의 프로필, 없을 경우 null
  Future<UserProfile?> execute({required String userEmail}) async {
    return await _userProfileRepository.getUserProfile(email: userEmail);
  }
}
