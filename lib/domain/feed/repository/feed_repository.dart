import 'package:weaco/domain/feed/model/feed.dart';

abstract interface class FeedRepository {
  /// 유저의 피드를 가져옵니다.
  Future<List<Feed>> getFeedList({required String email, int? page});
}
