import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';

class RefreshUserPageUseCase {
  final FeedRepository _feedRepository;

  const RefreshUserPageUseCase({
    required FeedRepository feedRepository,
  }) : _feedRepository = feedRepository;

  /// 유저가 특정 UserPage 에서 pull-to-refresh 상호작용을 했을 때,
  /// UserProfile 과 List<Feed> 를 반환.
  ///
  /// @param email 필수 파라미터, 특정 User 의 email 값.
  /// @param limit 선택 파라미터, 받아오고자  하는 feed 의 개수.
  /// @return List<Feed>? getFeedList() 메소드를 호출하여 받환 받은 List<Feed>? 데이터.
  Future<List<Feed>?> execute({
    required String email,
    DateTime? createdAt,
    int? limit = 20,
  }) async {
    List<Feed>? feedList;

    feedList = await _feedRepository.getFeedList(
      email: email,
      createdAt: null,
      limit: limit,
    );

    return feedList;
  }
}
