import 'package:weaco/domain/feed/model/feed.dart';

abstract interface class FeedRepository {
  Future<Feed?> getFeed({required String id});
}
