import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';

class MockFeedRepositoryImpl implements FeedRepository {
  List<Feed> _mockFeedList = [];

  @override
  Future<List<Feed>> getFeedList({required String email, int? page = 1}) {
    return Future.value(_mockFeedList);
  }

  void addFeedList({required List<Feed> feedList}) {
    _mockFeedList = feedList;
  }

  void initMockData() {
    _mockFeedList = [];
  }
}
