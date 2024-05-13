import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/ootd_feed_repository.dart';

class MockOotdFeedRepositoryImpl implements OotdFeedRepository {
  int saveOotdFeedCallCount = 0;
  int removeOotdFeedCallCount = 0;
  bool saveOotdFeedReturnValue = false;
  bool removeOotdFeedReturnValue = false;
  String removeOotdFeedParamId = '';
  Feed? saveOotdFeedParamFeed;

  void initMockData() {
    saveOotdFeedCallCount = 0;
    removeOotdFeedCallCount = 0;
    saveOotdFeedReturnValue = false;
    removeOotdFeedReturnValue = false;
    removeOotdFeedParamId = '';
    saveOotdFeedParamFeed = null;
  }

  @override
  Future<bool> removeOotdFeed({required String id}) async {
    removeOotdFeedCallCount++;
    removeOotdFeedParamId = id;

    return removeOotdFeedReturnValue;
  }

  @override
  Future<bool> saveOotdFeed({required Feed feed}) async {
    saveOotdFeedCallCount++;
    saveOotdFeedParamFeed = feed;

    return saveOotdFeedReturnValue;
  }
}
