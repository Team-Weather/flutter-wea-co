import 'package:flutter/cupertino.dart';
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
  Future<bool> deleteFeed({required String id, required String email}) async {
    try {
      /// email을 통해 User를 식별 하고 id를 통해 Firebase 내의 특정 피드를 삭제를 해야 한다.
      await remoteFeedDataSource.deleteFeed(id: id);

      /// 성공적으로 완료 시, 유저 프로필 카운트 -1
      userFeedCount = userFeedCount--;

      /// 성공적으로 완료 시, 완료(true) 응답을 ViewModel로 전달*ViewModel에서 데이터(상태)를 업데이트
      return true;
    } catch (e) {
      /// 실패 시, false 반환
      return false;
    }
  }

  /// 피드의 id 값을 전달 하여 Firebase 내의 해당 피드를 가져 와야 한다.
  /// GetDetailFeedDetailUseCase에서 사용
  /// @param id: 피드 id
  /// @return Feed: 피드
  @override
  Future<Feed?> getFeed({required String id}) {
    try {
      /// id를 통해 피드를 가져온다.
      return remoteFeedDataSource.getFeed(id: id);
    } catch (e) {
      /// 실패 시, Exception 발생
      throw Exception('Failed to get feed');
    }
  }

  /// GetMyPageFeedsUseCase, GetUserFeedListUseCase에서 사용
  /// 유저의 이메일을 통해 Firebase 내의 해당 유저의 피드 목록을 가져와야 한다.
  /// @param email: 유저 이메일
  /// @param createdAt: 피드 생성 시간
  /// @param limit: 피드 목록 갯수 제한
  @override
  Future<List<Feed>> getFeedList(
      {required String email,
      required DateTime? createdAt,
      required int? limit}) {
    /// 유저의 이메일을 통해 Firebase 내의 해당 유저의 피드 목록을 가져와야 한다.
    /// 생성일자(createdAt)를 기준으로 제한(limit)된 갯수의 피드 목록을 가져오고
    /// 최신 순으로 정렬하여 viewModel에 전달 해야 한다.
    try {
      return remoteFeedDataSource.getUserFeedList(
          email: email, createdAt: createdAt!, limit: limit!);
    } catch (e) {
      /// 실패 시, Exception 발생
      throw Exception('Failed to get feed list');
    }
  }

  /// GetOotdFeedsListUseCase에서 사용
  /// [OOTD 피드 화면]에 들어가면, Firebase에 최신 순(생성일 기준)으로 OOTD 피드 목록을 요청하여 가져와야 한다.
  /// 페이징 처리를 위해 createdAt을 기준으로 limit된 갯수의 피드 목록을 가져와야 한다.
  /// *이건 RemoteDataSource의 getRecommendedFeedList에서 미리 처리됨.
  @override
  Future<List<Feed>> getOotdFeedsList(
      {required DailyLocationWeather dailyLocationWeather}) async {
    try {
      /// Firebase에 추천 피드 데이터 요청
      return await remoteFeedDataSource.getRecommendedFeedList(
          dailyLocationWeather: dailyLocationWeather);
    } catch (e) {
      /// 실패 시, Exception 발생
      throw Exception('Failed to get ootd feed list');
    }
  }

  /// GetRecommendedFeedListUseCase에서 사용
  /// [홈 화면] 하단
  /// 유저의 위치와 날씨를 기반으로 Firebase에 요청하여 OOTD 피드 목록을 가져와야 한다.
  @override
  Future<List<Feed>> getRecommendedFeedList() {
    try {
      /// Firebase에 추천 피드 데이터 요청
      return remoteFeedDataSource.getRecommendedFeedList(
          dailyLocationWeather: DailyLocationWeather(
        highTemperature: highTemperature,
        lowTemperature: lowTemperature,
        weatherList: weatherList,
        location: location,
        createdAt: createdAt,
      ) // dailyLocationWeather는 ViewModel에서 전달 받아야??
          );
    } catch (e) {
      /// 실패 시, Exception 발생
      throw Exception('Failed to get recommended feed list');
    }
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

  /// 파일 레포에서 호출이 안됨. 현재!
  /// Future<String> saveOotdImage();
  /// 요 친구가 FileRepository 인터페이스에 추가될 것 같습니다
  Future<bool> saveFeed({required Feed editedFeed}) {
    // TODO: implement saveFeed
    throw UnimplementedError();
  }
}
