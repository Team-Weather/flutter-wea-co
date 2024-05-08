import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  @override
  Future<Feed?> deleteFeed({required String id}) {
    // TODO: implement deleteFeed
    throw UnimplementedError();
  }

  @override
  Future<Feed?> getFeed({required String id}) {
    // TODO: implement getFeed
    throw UnimplementedError();
  }

  @override
  Future<List<Feed>> getFeedList(
      {required String email,
      required DateTime? createdAt,
      required int? limit}) {
    // TODO: implement getFeedList
    throw UnimplementedError();
  }

  @override
  Future<List<Feed>> getOotdFeedsList({DateTime? createdAt}) {
    // TODO: implement getOotdFeedsList
    throw UnimplementedError();
  }

  @override
  Future<List<Feed>> getRecommendedFeedList() {
    // TODO: implement getRecommendedFeedList
    throw UnimplementedError();
  }

  @override
  Future<List<Feed>> getSearchFeedList(
      {DateTime? createdAt,
      int? limit,
      int? seasonCode,
      int? weatherCode,
      int? minTemperature,
      int? maxTemperature}) {
    // TODO: implement getSearchFeedList
    throw UnimplementedError();
  }

  @override
  Future<bool> saveFeed({required Feed editedFeed}) {
    // TODO: implement saveFeed
    throw UnimplementedError();
  }
}
