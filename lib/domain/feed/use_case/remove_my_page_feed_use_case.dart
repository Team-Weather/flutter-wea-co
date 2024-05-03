import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';

class RemoveMyPageFeedUseCase {
  final FeedRepository _feedRepository;

  RemoveMyPageFeedUseCase({required FeedRepository feedRepository})
      : _feedRepository = feedRepository;

  /// id를 통해 특정 피드를 삭제
  /// @param id: 삭제할 피드의 id
  /// @return: null
  Future<Feed?> execute({required String id}) async {
    return await _feedRepository.deleteFeed(id: id);
  }
}
