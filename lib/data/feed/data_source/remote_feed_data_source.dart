import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

abstract interface class RemoteFeedDataSource {
  /// OOTD 피드 작성 성공 시 : 피드 업로드 요청(Feed) -> / 업로드 완료(bool) ← 파베
  /// OOTD 편집 완료 후 [상세 페이지]:  위와 동일.
  /// OOTD 편집 완료 후 [마이 페이지]: 위와 동일.*피드 업데이트
  Future<bool> saveFeed({required Feed feed});

  /// OOTD 피드 [상세 페이지] : 피드 데이터 요청 (id) -> 파베 / 피드 데이터 반환(json) ← 파베
  Future<Map<String, dynamic>> getFeed({required String id});

  /// [유저 페이지/마이 페이지] :  피드 데이터 요청 (email) -> 파베 / 피드 데이터 반환(List<Feed>)← 파베
  Future<List<Feed>> getFeedList({required String email});

  /// [마이페이지] 피드 삭제: 피드 삭제 요청(id) -> 파베/ 삭제 완료 (bool) from FB
  Future<bool> deleteFeed({required String id});

  /// [홈 페이지] 하단 OOTD 추천:  피드 데이터 요청 (위치, 날씨) -> 피드 데이터 반환(List<Feed>) from FB
  /// [OOTD 피드 페이지] 카드뷰:  피드 예보 요청 (위치, 날씨) -> 피드 예보 반환(List<Feed>) from FB
  Future<List<Feed>> getRecommendedFeedList(
      {required Location location, required Weather weather});

  /// [검색 페이지] 피드 검색:
  /// 피드 데이터 요청(계절,날씨,온도) -> FB
  /// 피드 데이터 반환(List<Feed>) <- FB
  Future<List<Feed>> getSearchFeedList(
      {int? seasonCode, Weather? weather});
}
