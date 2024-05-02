import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';

/// 마이 페이지에서 유저의 피드 목록을 보여주기 위한 Use Case
class GetMyPageFeedsUseCase {
  final FeedRepository _feedRepository;

  GetMyPageFeedsUseCase({required FeedRepository feedRepository})
      : _feedRepository = feedRepository;

  Future<List<Feed>> execute({
    required String email,
    int? page = 1,
  }) async {
    List<Feed> feedList = [];
    try {
      feedList = await _feedRepository.getFeeds(email: email, page: page);
    } catch (e) {
      throw Exception(e);
    }
    return feedList;
  }
}
