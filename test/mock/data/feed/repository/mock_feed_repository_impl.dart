import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';

class MockFeedRepositoryImpl implements FeedRepository {
  List<Feed> mockFeedList = [];
  int getFeedListcallCount = 0;

  @override
  Future<List<Feed>> getFeedList({
    required String email,
    required DateTime? createdAt,
    required int? limit,
  }) async {
    getFeedListcallCount++;
    return await Future.value(mockFeedList);
  }

  void addFeedList({required List<Feed> feedList}) {
    mockFeedList = feedList;
  }

  void initMockData() {
    mockFeedList.clear();
    getFeedListcallCount = 0;
  }
}
