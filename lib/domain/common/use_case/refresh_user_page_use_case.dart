import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_my_page_feeds_use_case.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/get_user_page_user_profile_use_case.dart';

class RefreshUserPageUseCase {
  final GetUserPageUserProfileUseCase _getUserPageUserProfileUseCase;
  final GetMyPageFeedsUseCase _getMyPageFeedsUseCase;

  RefreshUserPageUseCase({
    required GetUserPageUserProfileUseCase getUserPageUserProfileUseCase,
    required GetMyPageFeedsUseCase getMyPageFeedsUseCase,
  })  : _getUserPageUserProfileUseCase = getUserPageUserProfileUseCase,
        _getMyPageFeedsUseCase = getMyPageFeedsUseCase;

  /// 유저가 특정 UserPage 에서 pull-to-refresh 상호작용을 했을 때,
  /// UserProfile 과 List<Feed> 를 반환.
  ///
  /// @param [email] 필수 파라미터, 특정 User 의 email 값.
  /// @param [limit] 선택 파라미터, 받아오고자  하는 feed 의 개수.
  /// @return RefreshUserPageUseCase 를 Facade 패턴으로
  /// GetUserPageUserProfileUseCase, GetMyPageFeedsUseCase 를 사용하여
  /// Map 콜렉션으로 감싼 UserProfile, List<Feed>? 데이터.
  Future<Map<String, dynamic>> execute({
    required String email,
    int? limit = 20,
  }) async {
    UserProfile? userProfile;
    List<Feed>? feedList;

    userProfile =
        await _getUserPageUserProfileUseCase.execute(userEmail: email);

    feedList = await _getMyPageFeedsUseCase.execute(
      email: email,
      createdAt: null,
      limit: limit,
    );

    return {
      'userProfile': userProfile,
      'feedList': feedList,
    };
  }
}
