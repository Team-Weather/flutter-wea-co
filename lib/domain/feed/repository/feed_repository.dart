import 'package:weaco/domain/feed/model/feed.dart';

abstract interface class FeedRepository {
  /// 유저의 피드를 가져옵니다.
  Future<List<Feed>> getFeedList({
    required String email,
    required DateTime? createdAt,
    required int? limit,
  });

  Future<List<Feed>> getRecommendedFeeds(
      {int? seasonCode,
      int? weatherCode,
      int? minTemperature,
      int? maxTemperature});

  Future<List<Feed>> getSearchFeedList({
    int? limit = 20,
    DateTime? createdAt,
    int? seasonCode,
    int? weatherCode,
    int? minTemperature,
    int? maxTemperature,
  });

  Future<Feed?> getFeed({required String id});

  /// OOTD 피드를 최신 순으로 가져옵니다.
  Future<List<Feed>> getOotdFeedsList({required DateTime? createdAt});

  Future<Feed?> deleteFeed({required String id});

  Future<bool> saveFeed({required Feed editedFeed});
}
