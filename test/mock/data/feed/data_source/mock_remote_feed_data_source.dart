// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weaco/data/feed/data_source/remote_feed_data_source.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';

class MockRemoteFeedDataSource implements RemoteFeedDataSource {
  List<Feed> feedList = [];
  bool saveFeedReturnValue = false;
  bool deleteFeedReturnValue = false;
  String deleteFeedParamId = '';
  Map<String, dynamic> paramMap = {};
  String getFeedId = '';

  void cleanUpMockData() {
    feedList = [];
    saveFeedReturnValue = false;
    deleteFeedParamId = '';
    deleteFeedReturnValue = false;
    getFeedId = '';
    paramMap.clear();
  }

  @override
  Future<bool> deleteFeed({required String id}) async {
    deleteFeedParamId = id;
    return deleteFeedReturnValue;
  }

  @override
  Future<Feed> getFeed({required String id}) async {
    getFeedId = id;
    return feedList.first;
  }

  @override
  Future<List<Feed>> getRecommendedFeedList(
      {required DailyLocationWeather dailyLocationWeather, createdAt}) async {
    return feedList;
  }

  @override
  Future<List<Feed>> getSearchFeedList({
    DateTime? createdAt,
    required int limit,
    int? seasonCode,
    int? weatherCode,
    int? minTemperature,
    int? maxTemperature,
  }) async {
    paramMap['createdAt'] = createdAt;
    paramMap['limit'] = limit;
    paramMap['seasonCode'] = seasonCode;
    paramMap['weatherCode'] = weatherCode;
    paramMap['minTemperature'] = minTemperature;
    paramMap['maxTemperature'] = maxTemperature;

    return feedList;
  }

  @override
  Future<List<Feed>> getUserFeedList({
    DateTime? createdAt,
    required String email,
    required int limit,
  }) async {
    return feedList;
  }

  @override
  Future<bool> saveFeed({required Feed feed}) async {
    if (saveFeedReturnValue) {
      feedList.add(feed);
    }
    return saveFeedReturnValue;
  }
}
