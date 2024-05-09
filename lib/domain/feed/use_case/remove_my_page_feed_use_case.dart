import 'package:weaco/domain/feed/repository/feed_repository.dart';

class RemoveMyPageFeedUseCase {
  final FeedRepository _feedRepository;

  RemoveMyPageFeedUseCase({required FeedRepository feedRepository})
      : _feedRepository = feedRepository;

  /// id를 통해 특정 피드를 삭제
  /// @param id: 삭제할 피드의 id
  /// @return: null
  /// 요 피드(id)를 삭제해 줄래?
  Future<bool> execute({required String id, required String email}) async {
    return await _feedRepository.deleteFeed(id: id, email: email);
  }
}
