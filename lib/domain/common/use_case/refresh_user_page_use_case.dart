import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_user_page_feeds_use_case.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/get_user_page_user_profile_use_case.dart';

class RefreshUserPageUseCase {
  final GetUserPageUserProfileUseCase _getUserPageUserProfileUseCase;
  final GetUserPageFeedsUseCase _getUserPageFeedsUseCase;

  RefreshUserPageUseCase({
    required GetUserPageUserProfileUseCase getUserPageUserProfileUseCase,
    required GetUserPageFeedsUseCase getUserPageFeedsUseCase,
  })  : _getUserPageUserProfileUseCase = getUserPageUserProfileUseCase,
        _getUserPageFeedsUseCase = getUserPageFeedsUseCase;

  /// 유저가 특정 UserPage 에서 pull-to-refresh 상호작용을 했을 때,
  /// UserProfile 과 List<Feed> 를 반환.
  ///
  /// RefreshUserPageUseCase 를 Facade 패턴으로
  /// GetUserPageUserProfileUseCase, GetUserPageFeedsUseCase 를 사용
  ///
  /// @param [email] 필수 파라미터, 특정 User 의 email 값.
  /// @param [limit] 선택 파라미터, 받아오고자  하는 feed 의 개수.
  /// @return Map 으로 감싼 UserProfile, List<Feed>? 데이터.
  Future<Map<String, dynamic>> execute({
    required String email,
    DateTime? createdAt,
    int? limit = 20,
  }) async {
    UserProfile? userProfile;
    List<Feed>? feedList;

    userProfile =
        await _getUserPageUserProfileUseCase.execute(userEmail: email);

    feedList = await _getUserPageFeedsUseCase.execute(
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
