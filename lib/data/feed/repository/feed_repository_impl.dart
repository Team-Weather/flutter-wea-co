import 'package:weaco/data/feed/data_source/remote_feed_data_source.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';

class FeedRepositoryImpl implements FeedRepository {
  final RemoteFeedDataSource remoteFeedDataSource;
  late final int userFeedCount;

  FeedRepositoryImpl(
      {required this.userFeedCount, required this.remoteFeedDataSource});

  @override
  Future<bool> deleteFeed({required String id}) async {
    return await remoteFeedDataSource.deleteFeed(id: id);
  }

  /// 피드의 id 값을 전달 하여 Firebase 내의 해당 피드를 가져 와야 한다.
  /// GetDetailFeedDetailUseCase에서 사용
  /// @param id: 피드 id
  /// @return Feed: 피드
  @override
  Future<Feed?> getFeed({required String id}) async {
    return await remoteFeedDataSource.getFeed(id: id);
  }

  /// GetMyPageFeedsUseCase, GetUserFeedListUseCase에서 사용
  /// 유저의 이메일을 통해 Firebase 내의 해당 유저의 피드 목록을 가져와야 한다.
  /// @param email: 유저 이메일
  /// @param createdAt: 피드 생성 시간
  /// @param limit: 피드 목록 갯수 제한
  @override
  Future<List<Feed>> getUserFeedList({
    required String email,
    required DateTime? createdAt,
    required int? limit,
  }) async {
    return remoteFeedDataSource.getUserFeedList(
        email: email, createdAt: createdAt!, limit: limit!);
  }

  /// GetOotdFeedsListUseCase에서 사용
  /// [OOTD 피드 화면]에 들어가면, Firebase에 최신 순(생성일 기준)으로 OOTD 피드 목록을 요청하여 가져와야 한다.
  /// 페이징 처리를 위해 createdAt을 기준으로 limit된 갯수의 피드 목록을 가져와야 한다.
  /// *이건 RemoteDataSource의 getRecommendedFeedList에서 미리 처리됨.
  @override
  Future<List<Feed>> getOotdFeedList({
    required DateTime createdAt,
    required DailyLocationWeather dailyLocationWeather,
  }) async {
    return await remoteFeedDataSource.getRecommendedFeedList(
        dailyLocationWeather: dailyLocationWeather);
  }

  /// GetRecommendedFeedListUseCase에서 사용
  /// [홈 화면] 하단
  /// 유저의 위치와 날씨를 기반으로 Firebase에 요청하여 OOTD 피드 목록을 가져와야 한다.

  @override
  Future<List<Feed>> getRecommendedFeedList({
    required DailyLocationWeather dailyLocationWeather,
  }) async {
    return remoteFeedDataSource.getRecommendedFeedList(
      dailyLocationWeather: dailyLocationWeather,
    );
  }

  @override
  Future<List<Feed>> getSearchFeedList({
    DateTime? createdAt,
    int? limit,
    int? seasonCode,
    int? weatherCode,
    int? minTemperature,
    int? maxTemperature,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveFeed({required Feed editedFeed}) {
    return remoteFeedDataSource.saveFeed(feed: editedFeed);
  }
}
