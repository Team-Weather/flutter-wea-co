import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/ootd_feed_repository.dart';

class SaveEditFeedUseCase {
  final OotdFeedRepository _ootdFeedRepository;

  SaveEditFeedUseCase({required OotdFeedRepository ootdFeedRepository})
      : _ootdFeedRepository = ootdFeedRepository;

  /// 특정 피드 저장 또는 업데이트
  /// @param feed: 저장할 피드
  /// @return: 서버 응답 메세지. response 모델로 변경 예정.
  Future<bool> execute({required Feed feed}) async {
    return await _ootdFeedRepository.saveOotdFeed(feed: feed);
  }
}
