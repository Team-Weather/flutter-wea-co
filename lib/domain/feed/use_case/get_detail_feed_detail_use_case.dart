import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';

class GetDetailFeedDetailUseCase {
  final FeedRepository _feedRepository;

  GetDetailFeedDetailUseCase({required FeedRepository feedRepository})
      : _feedRepository = feedRepository;

  /// 레포지토리에 피드 id를 전달하여 해당 피드를 가져온다.
  /// @param id: 피드 id
  /// @return Feed: 피드
  Future<Feed?> execute({required String id}) async {
    return await _feedRepository.getFeed(id: id);
  }
}
