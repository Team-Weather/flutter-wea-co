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

  Future<Feed?> getFeed({required String id});

  Future<List<Feed>> getSearchFeeds(
      {int? seasonCode,
      int? weatherCode,
      int? minTemperature,
      int? maxTemperature});
}
