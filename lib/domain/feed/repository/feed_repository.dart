import 'package:weaco/domain/feed/model/feed.dart';

abstract interface class FeedRepository {
  Future<List<Feed>> getRecommendedFeeds(
      {int? seasonCode,
      int? weatherCode,
      int? minTemperature,
      int? maxTemperature});
}
