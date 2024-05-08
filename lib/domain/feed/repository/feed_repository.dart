import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';

abstract interface class FeedRepository {
  /// 유저의 피드를 가져옵니다.
  Future<List<Feed>> getFeedList({
    required String email,
    required DateTime? createdAt,
    required int? limit,
  });

  Future<Feed?> getFeed({required String id});

  Future<Feed?> deleteFeed({required String id});

  Future<bool> saveFeed({required Feed editedFeed});

  Future<List<Feed>> getRecommendedFeedList({
    required DailyLocationWeather dailyLocationWeather,
  });

  Future<List<Feed>> getSearchFeedList({
    DateTime? createdAt,
    int? limit,
    int? seasonCode,
    int? weatherCode,
    int? minTemperature,
    int? maxTemperature,
  });

  /// OOTD 피드를 최신 순으로 가져옵니다.
  Future<List<Feed>> getOotdFeedsList({DateTime? createdAt});
}
