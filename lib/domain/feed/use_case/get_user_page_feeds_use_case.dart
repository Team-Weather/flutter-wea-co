import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';

/// 유저 페이지에서 유저의 피드 목록을 보여주기 위한 Use Case
class GetUserPageFeedsUseCase {
  final FeedRepository _feedRepository;

  GetUserPageFeedsUseCase({required FeedRepository feedRepository})
      : _feedRepository = feedRepository;

  Future<List<Feed>> execute({
    required String email,
    required DateTime? createdAt,
    int? limit = 20,
  }) async {
    return await _feedRepository.getUserFeedList(
      email: email,
      createdAt: createdAt,
      limit: limit,
    );
  }
}
