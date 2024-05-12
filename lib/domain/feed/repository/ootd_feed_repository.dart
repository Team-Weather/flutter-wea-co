import 'package:weaco/domain/feed/model/feed.dart';

abstract interface class OotdFeedRepository {
  Future<bool> saveOotdFeed({required Feed feed});

  Future<bool> removeOotdFeed({required String id});
}