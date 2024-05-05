import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';

class MockFeedRepositoryImpl implements FeedRepository {
  int getFeedListcallCount = 0;
  int getFeedCallCount = 0;
  int getRecommendedFeedsCallCount = 0;
  int getSearchFeedsCallCount = 0;
  String getFeedParamId = '';
  // 메서드 호출시 인자 확인을 위한 map
  final Map<String, dynamic> methodParameterMap = {};
  final List<Feed> _fakeFeedList = [];
  Feed? getFeedResult;
  Feed? feed;
  Map<String, dynamic> feedMap = {};
  int saveFeedCallCount = 0;

  @override
  Future<List<Feed>> getFeedList({
    required String email,
    required DateTime? createdAt,
    required int? limit,
  }) async {
    getFeedListcallCount++;
    methodParameterMap['email'] = email;
    methodParameterMap['limit'] = limit;
    methodParameterMap['createdAt'] = createdAt;
    return await Future.value(_fakeFeedList);
  }

  void addFeedList({required List<Feed> feedList}) {
    _fakeFeedList.clear();
    _fakeFeedList.addAll(feedList);
  }

  void initMockData() {
    saveFeedCallCount = 0;
    getFeedListcallCount = 0;
    getFeedCallCount = 0;
    getRecommendedFeedsCallCount = 0;
    getSearchFeedsCallCount = 0;
    methodParameterMap.clear();
    _fakeFeedList.clear();
    getFeedResult = null;
  }

  /// [getFeedCallCount] + 1
  /// [getFeedParamId]에 [id] 저장
  /// [getFeedResult] 반환
  @override
  Future<Feed?> getFeed({required String id}) async {
    getFeedCallCount++;
    methodParameterMap['id'] = id;
    return getFeedResult;
  }

  /// [_fakeFeedList]에서 조건에 맞는 피드 데이터를 찾아서 리스트로 반환
  /// 호출시 [getRecommendedFeedsCallCount] + 1
  @override
  Future<List<Feed>> getRecommendedFeeds(
      {int? seasonCode,
      int? weatherCode,
      int? minTemperature,
      int? maxTemperature}) {
    getRecommendedFeedsCallCount++;
    methodParameterMap['seasonCode'] = seasonCode;
    methodParameterMap['weatherCode'] = weatherCode;
    methodParameterMap['minTemperature'] = minTemperature;
    methodParameterMap['maxTemperature'] = maxTemperature;

    List<Feed> result = _fakeFeedList;

    if (seasonCode != null) {
      result =
          result.where((element) => element.seasonCode == seasonCode).toList();
    }

    if (weatherCode != null) {
      result = result
          .where((element) => element.weather.code == weatherCode)
          .toList();
    }

    if (minTemperature != null && maxTemperature != null) {
      result = result
          .where((element) =>
              element.weather.temperature >= minTemperature &&
              element.weather.temperature <= maxTemperature)
          .toList();
    }

    return Future.value(result);
  }

  /// [_fakeFeedList]에서 조건에 맞는 피드 데이터를 찾아서 리스트로 반환
  /// 호출시 [getSearchFeedsCallCount] + 1
  @override
  Future<List<Feed>> getSearchFeedList({
    int? limit = 20,
    DateTime? createdAt,
    int? seasonCode,
    int? weatherCode,
    int? minTemperature,
    int? maxTemperature,
  }) {
    getSearchFeedsCallCount++;
    methodParameterMap['limit'] = limit;
    methodParameterMap['createdAt'] = createdAt;
    methodParameterMap['seasonCode'] = seasonCode;
    methodParameterMap['weatherCode'] = weatherCode;
    methodParameterMap['minTemperature'] = minTemperature;
    methodParameterMap['maxTemperature'] = maxTemperature;

    List<Feed> result = _fakeFeedList;

    if (seasonCode != null) {
      result =
          result.where((element) => element.seasonCode == seasonCode).toList();
    }

    if (weatherCode != null) {
      result = result
          .where((element) => element.weather.code == weatherCode)
          .toList();
    }

    if (minTemperature != null && maxTemperature != null) {
      result = result
          .where((element) =>
              element.weather.temperature >= minTemperature &&
              element.weather.temperature <= maxTemperature)
          .toList();
    }

    if (createdAt != null) {
      result = result
          .where((e) =>
              e.createdAt.isAtSameMomentAs(createdAt) ||
              e.createdAt.isBefore(createdAt))
          .toList();
    }

    if (limit != null) {
      result = result.take(limit).toList();
    } else {
      result = result.take(20).toList();
    }

    return Future.value(result);
  }

  /// [_fakeFeedList]에 피드 추가
  void addFeed({required Feed feed}) {
    _fakeFeedList.add(feed);
  }

  /// [_fakeFeedList]의 모든 피드 삭제
  void resetFeedList() {
    _fakeFeedList.clear();
  }

  @override
  Future<Feed?> deleteFeed({required String id}) async {
    return feedMap.remove(id);
  }

  @override
  Future<bool> saveFeed({required Feed editedFeed}) async {
    saveFeedCallCount++;
    feed = editedFeed;
    if (editedFeed.id!.isNotEmpty) return true;
    return true;
  }
}
