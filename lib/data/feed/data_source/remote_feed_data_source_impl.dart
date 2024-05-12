import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/core/exception/not_found_exception.dart';
import 'package:weaco/core/firebase/firestore_dto_mapper.dart';
import 'package:weaco/data/feed/data_source/remote_feed_data_source.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';

class RemoteFeedDataSourceImpl implements RemoteFeedDataSource {
  final FirebaseFirestore _fireStore;

  const RemoteFeedDataSourceImpl({
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore;

  /// OOTD 피드 작성 또는 편집 후 저장
  @override
  Future<bool> saveFeed({required Feed feed}) async {
    final feedDto = toFeedDto(feed: feed);

    // 피드를 수정 할 경우
    if (feed.id != null) {
      return await _fireStore
          .collection('feeds')
          .doc(feed.id)
          .set(feedDto)
          .then((value) => true);
    }

    // 새 피드를 저장 할 경우
    return await _fireStore
        .collection('feeds')
        .add(feedDto)
        .then((value) => true);
  }

  /// [OOTD 피드 상세 페이지]:
  /// 피드 데이터 요청 (id) -> 파베 / 피드 데이터 반환(json) ← 파베
  @override
  Future<Feed> getFeed({required String id}) async {
    final docSnapshot = await _fireStore.collection('feeds').doc(id).get();

    if (docSnapshot.data() == null) {
      throw NotFoundException(
        code: 500,
        message: '피드가 존재하지 않습니다.',
      );
    }

    return toFeed(feedDto: docSnapshot.data()!, id: docSnapshot.id);
  }

  /// [유저 페이지/마이 페이지]:
  /// 피드 데이터 요청 (email) -> 파베 / 피드 데이터 반환(List<Feed>)← 파베
  @override
  Future<List<Feed>> getUserFeedList({
    required String email,
    DateTime? createdAt,
    required int limit,
  }) async {
    final querySnapshot = await _fireStore
        .collection('feeds')
        .where('user_email', isEqualTo: email)
        .where('deleted_at', isNull: true)
        .where('created_at',
            isLessThan: createdAt ?? Timestamp.fromDate(DateTime.now()))
        .orderBy('created_at', descending: true)
        .limit(limit)
        .get();

    return querySnapshot.docs
        .map((doc) => toFeed(feedDto: doc.data(), id: doc.id))
        .toList();
  }

  /// [마이페이지] 피드 삭제
  /// soft delete 처리
  @override
  Future<bool> deleteFeed({required String id}) async {
    await _fireStore
        .collection('feeds')
        .doc(id)
        .update({'deleted_at': Timestamp.fromDate(DateTime.now())});
    return true;
  }

  /// [홈 페이지] 하단 OOTD 추천:
  /// 피드 데이터 요청 (날씨) -> 파베
  /// 피드 데이터 반환(List<Feed>) <- 파베
  @override
  Future<List<Feed>> getRecommendedFeedList({
    required DailyLocationWeather dailyLocationWeather,
  }) async {
    final weather = dailyLocationWeather.weatherList[0];
    final querySnapshot = await _fireStore
        .collection('feeds')
        .where('weather.code', isEqualTo: weather.code)
        .where('season_code', isEqualTo: dailyLocationWeather.seasonCode)
        .where(
          'weather.temperature',
          isLessThanOrEqualTo: dailyLocationWeather.highTemperature,
          isGreaterThanOrEqualTo: dailyLocationWeather.lowTemperature,
        )
        .where('deleted_at', isNull: true)
        .orderBy('created_at', descending: true)
        .limit(10)
        .get();

    return querySnapshot.docs
        .map((doc) => toFeed(feedDto: doc.data(), id: doc.id))
        .toList();
  }

  /// [검색 페이지] 피드 검색:
  /// 피드 데이터 요청(계절,날씨,온도) -> FB
  /// 피드 데이터 반환(List<Feed>) <- FB

  @override
  Future<List<Feed>> getSearchFeedList({
    DateTime? createdAt,
    required int limit,
    int? seasonCode,
    int? weatherCode,
    int? minTemperature,
    int? maxTemperature,
  }) async {
    Query<Map<String, dynamic>> query = _fireStore.collection('feeds');
    // 날씨 코드 필터링
    if (weatherCode != null) {
      query = query.where('weather.code', isEqualTo: weatherCode);
    }

    // 온도 범위 필터링
    if (minTemperature != null && maxTemperature != null) {
      query = query
          .where('weather.temperature', isLessThanOrEqualTo: maxTemperature)
          .where('weather.temperature', isGreaterThanOrEqualTo: minTemperature);
    }

    // 계절 코드 필터링
    if (seasonCode != null) {
      query = query.where('season_code', isEqualTo: seasonCode);
    }

    // 생성일 기준으로 정렬하여 제한된 수의 문서 가져오기
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await query
        .where('created_at',
            isLessThan: createdAt ?? Timestamp.fromDate(DateTime.now()))
        .where('deleted_at', isNull: true)
        .orderBy(
          'created_at',
          descending: true,
        )
        .limit(limit)
        .get();

    return querySnapshot.docs
        .map((doc) => toFeed(feedDto: doc.data(), id: doc.id))
        .toList();
  }
}
