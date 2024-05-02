import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';

class MockFeedRepositoryImpl implements FeedRepository {
  int getFeedCallCount = 0;
  String getFeedParamId = '';
  Feed? getFeedResult;

  void initMockData() {
    getFeedCallCount = 0;
    getFeedParamId = '';
    getFeedResult = null;
  }

  /// [getFeedCallCount] + 1
  /// [getFeedParamId]에 [id] 저장
  /// [getFeedResult] 반환
  @override
  Future<Feed?> getFeed({required String id}) async {
    getFeedCallCount++;
    getFeedParamId = id;

    return getFeedResult;
  }
}
