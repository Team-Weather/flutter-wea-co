import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/data/feed/data_source/remote_feed_data_source.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

class RemoteFeedDataSourceImpl implements RemoteFeedDataSource {
  final FirebaseFirestore _fireStore;

  const RemoteFeedDataSourceImpl({
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore;

  /// OOTD 피드 작성 성공 시 : 피드 업로드 요청(Feed) -> / 업로드 완료(bool) ← 파베
  /// OOTD 편집 완료 후 [상세 페이지]:  위와 동일.
  /// OOTD 편집 완료 후 [마이 페이지]: 위와 동일.*피드 업데이트
  @override
  Future<bool> saveFeed({required Feed feed}) async {
    DocumentReference docRef = await _fireStore.collection("feeds").add({
      'id': feed.id,
      'createdAt': feed.createdAt,
      'deletedAt': feed.deletedAt,
      'description': feed.description,
      'imagePath': feed.imagePath,
      'seasonCode': feed.seasonCode,
      'userEmail': feed.userEmail,
    });

    await docRef.collection('location').add({
      'lat': feed.location.lat,
      'lng': feed.location.lng,
      'city': feed.location.city,
      'createdAt': feed.location.createdAt,
    });
    await docRef.collection('weather').add({
      'temperature': feed.weather.temperature,
      'timeTemperature': feed.weather.timeTemperature,
      'code': feed.weather.code,
      'createdAt': feed.weather.createdAt,
    });

    return true;
  }

  /// [OOTD 피드 상세 페이지]:
  /// 피드 데이터 요청 (id) -> 파베 / 피드 데이터 반환(json) ← 파베
  @override
  Future<Map<String, dynamic>> getFeed({required String id}) async {
    DocumentSnapshot docSnapshot =
        await _fireStore.collection("feeds").doc(id).get();
    return docSnapshot.data() as Map<String, dynamic>;
  }

  /// [유저 페이지/마이 페이지]:
  /// 피드 데이터 요청 (email) -> 파베 / 피드 데이터 반환(List<Feed>)← 파베
  @override
  Future<List<Feed>> getFeedList({required String email}) async {
    QuerySnapshot querySnapshot = _fireStore
        .collection("feeds")
        .where('email', isEqualTo: email)
        .get() as QuerySnapshot;
    return querySnapshot.docs.map((e) => e.data()) as List<Feed>;
  }

  /// [마이페이지] 피드 삭제:
  /// 피드 삭제 요청(id) -> 파베/ 삭제 완료 (bool) <- 파베
  @override
  Future<bool> deleteFeed({required String id}) async {
    _fireStore.collection("feeds").doc(id).delete();
    return true;
  }

  /// [홈 페이지] 하단 OOTD 추천:
  /// 피드 데이터 요청 (위치, 날씨) -> 파베
  /// 피드 데이터 반환(List<Feed>) <- 파베
  @override
  Future<List<Feed>> getRecommendedFeedList({
    required String city,
    required double temperature
  }) async {
    final querySnapshot = await _fireStore
        .collection('feeds')
        .where('location.city', isEqualTo: city)
        .where('weather.temperature', isEqualTo: temperature)
        .limit(10)
        .get();

    return querySnapshot.docs.map((e) => Feed.fromJson(e.data())).toList();
  }

  /// [검색 페이지] 피드 검색:
  /// 피드 데이터 요청(계절,날씨,온도) -> FB
  /// 피드 데이터 반환(List<Feed>) <- FB

  @override
  Future<List<Feed>> getSearchFeedList({
    required DateTime createdAt,
    required int limit,
    int? seasonCode,
    int? weatherCode,
    int? minTemperature,
    int? maxTemperature,
  }) async {
    final querySnapshot = await _fireStore
        .collection('feeds')
        .where('weather.code', isEqualTo: weatherCode)
        .where(
          'weather.temperature',
          isLessThanOrEqualTo: maxTemperature,
          isGreaterThanOrEqualTo: minTemperature,
        )
        .where('season_code', isEqualTo: seasonCode)
        .orderBy('created_at', descending: false)
        .limit(10)
        .get();

    return querySnapshot.docs.map((e) => Feed.fromJson(e.data())).toList();
  }
}
